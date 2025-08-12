package com.example.starter

import android.content.Context
import android.content.SharedPreferences
import androidx.core.content.edit

class SharedPreferencesHelper(context: Context) {
    private val sharedPreferences: SharedPreferences =
        context.getSharedPreferences("MyAppPreferences", Context.MODE_PRIVATE)

    fun putString(key:String, value: String) {
        sharedPreferences.edit() {
            putString(key, value)
        }
    }

    fun getString(key: String): String? {
        return sharedPreferences.getString(key, null)
    }

    fun remove(key: String) {
        sharedPreferences.edit() { remove(key) }
    }

    fun clearAllPreferences() {
        sharedPreferences.edit() { clear() }
    }
}