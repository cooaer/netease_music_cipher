package app.dier.netease_music_cipher;

import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * NeteaseMusicCipherPlugin
 */
public class NeteaseMusicCipherPlugin
        implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "netease_music_cipher");
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "netease_music_cipher");
        channel.setMethodCallHandler(new NeteaseMusicCipherPlugin());
    }

    @Override
    public void onMethodCall(final @NonNull MethodCall call, final @NonNull Result result) {
        String method = call.method;
        if (method.equals("encryptWeapi") || method.equals("encryptEapi")) {
            executorService.submit(() -> {
                try {
                    HashMap<String, String> data = new HashMap<>();
                    if (method.equals("encryptWeapi")) {
                        final String content = (String) call.arguments;
                        data = ApiEncrypt.encryptWeapi(content);
                    } else {
                        final List<String> params = (List<String>) call.arguments;
                        try {
                            data = ApiEncrypt.encryptEapi(params.get(0), params.get(1));
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    HashMap<String, String> finalData = data;
                    new Handler(Looper.getMainLooper()).post(() -> result.success(finalData));
                } catch (Exception e) {
                    new Handler(Looper.getMainLooper()).post(() -> result.error("EXCEPTION", e.getMessage(), null));
                }
            });
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
