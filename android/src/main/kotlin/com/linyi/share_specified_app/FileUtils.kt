package com.linyi.share_specified_app

import android.content.Context
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import java.io.File

object FileUtils {
    fun getUriForFile(context: Context, file: File): Uri {
        if (Build.VERSION.SDK_INT > 24) {
            return FileProvider.getUriForFile(context, context.packageName + ".fileProvider", file)
        }
        return Uri.fromFile(file)
    }
}