package com.fiveeplay.flbugly;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

//import com.tencent.bugly.Bugly;
import com.tencent.bugly.crashreport.CrashReport;

import org.json.JSONObject;

import java.util.HashMap;

import io.flutter.BuildConfig;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlBuglyPlugin */
public class FlBuglyPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private FlutterPluginBinding flutterPluginBinding;

  private Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "report":
        postException(call);
        break;
      case "startWithAppId":
        initBugly(call);
        break;
      case "setUserIdentifier":
          String userId = (String)call.arguments;
          CrashReport.setUserId(activity, userId);
        break;
      case "setUserValueAndKey":
        if (call.hasArgument("key") && call.hasArgument("value")) {
          String userDataKey = call.argument("key");
          String userDataValue = call.argument("value");
          CrashReport.putUserData(activity, userDataKey, userDataValue);
        }
        break;
      case "setTag":
        int tag = (int)call.arguments;
        CrashReport.setUserSceneTag(activity, tag);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void initBugly(MethodCall call) {
    String andriodAppId ="";
    HashMap<String, Object> config = null;
    if (call.hasArgument("andriodAppId")) {
      andriodAppId = call.argument("andriodAppId");
    }

//    CrashReport.initCrashReport();
    CrashReport.initCrashReport(activity, andriodAppId, false);

    if (call.hasArgument("config")) {
      config = call.argument("config");
    }

    if (config == null) {
      return;
    }

    boolean debugMode = (boolean)config.get("debugMode");
    CrashReport.setIsDevelopmentDevice(CrashReport.getContext(), debugMode);

    String channel = (String) config.get("channel");
    if (!TextUtils.isEmpty(channel)) {
      CrashReport.setAppChannel(CrashReport.getContext(), channel);
    }

    String version = (String) config.get("version");
    if (!TextUtils.isEmpty(version)) {
      CrashReport.setAppVersion(CrashReport.getContext(), version);
    }

    String deviceIdentifier = (String) config.get("deviceIdentifier");
    if (!TextUtils.isEmpty(deviceIdentifier)) {
      CrashReport.setDeviceId(CrashReport.getContext(), deviceIdentifier);
    }
  }

  private void postException(MethodCall call) {
    String exception = "";
    String stackTrace = null;
    if (call.hasArgument("exception")) {
      exception = call.argument("exception");
    }
    if (call.hasArgument("stackTrace")) {
      stackTrace = call.argument("stackTrace");
    }
    if (TextUtils.isEmpty(stackTrace)) {
      return;
    }
    CrashReport.postException(8, "Flutter Exception", exception, stackTrace, null);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    flutterPluginBinding = null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "jacketxia/fl_bugly");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

}
