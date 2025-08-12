package com.nfach98.starter

import com.example.starter.SharedPreferencesHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val SP_CHANNEL = "shared_pref"
    private lateinit var prefsHelper: SharedPreferencesHelper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        prefsHelper = SharedPreferencesHelper(applicationContext)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SP_CHANNEL
        ).setMethodCallHandler { call, result ->
            val key = call.argument<String>("key") ?: ""
            val value = call.argument<String>("value") ?: ""

            if (call.method == "putString") {
                prefsHelper.putString(key, value)
                result.success("Data saved successfully")
            } else if (call.method == "getString") {
                val data = prefsHelper.getString(key)
                result.success(data)
            }  else if (call.method == "remove") {
                prefsHelper.remove(key)
                result.success("Data removed successfully")
            } else {
                result.notImplemented()
            }
        }
    }
}
