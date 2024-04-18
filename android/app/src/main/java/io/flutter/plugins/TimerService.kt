package com.example.attention

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import androidx.core.app.NotificationCompat
import android.os.CountDownTimer
import android.net.Uri
import android.media.AudioAttributes
import android.app.PendingIntent
import android.content.Context

class TimerService : Service() {
    private var timer: CountDownTimer? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val duration = intent?.getIntExtra("duration", 0) ?: 0
        startForeground(1, getNotification(duration))
    
        timer?.cancel()
        timer = object : CountDownTimer((duration * 1000).toLong(), 1000) {
            override fun onTick(millisUntilFinished: Long) {
                updateNotification((millisUntilFinished / 1000).toInt())
            }
    
            override fun onFinish() {
                stopSelf()
                showTimeUpNotification()
            }
        }.start()
    
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        timer?.cancel()  // Cancel the timer when the service is stopped
        stopSelf()  // Optionally clear all notifications
    }

    private fun showTimeUpNotification() {
        val channelId = createTimeUpNotificationChannel()
        val intent = Intent(this, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    
        val notification = NotificationCompat.Builder(this, channelId).apply {
            setContentTitle("Time's Up")
            setContentText("The countdown has finished.")
            setSmallIcon(R.mipmap.ic_launcher)
            setContentIntent(pendingIntent)
            setAutoCancel(true)
            setPriority(NotificationCompat.PRIORITY_HIGH)
        }.build()
    
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.notify(2, notification)  // Use a different ID to ensure it doesn't replace the ongoing notification
    }
    

    private fun createTimeUpNotificationChannel(): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "time_up_channel"
            val channelName = "Time Up Alerts"
            val soundUri: Uri = Uri.parse("android.resource://${packageName}/raw/time_up_sound")  // Ensure you have a sound file at res/raw/time_up_sound.mp3
            val attributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()
    
            val channel = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_HIGH).apply {
                setSound(soundUri, attributes)
                lockscreenVisibility = Notification.VISIBILITY_PUBLIC
            }
            val notificationManager: NotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
            return channelId
        }
        return ""
    }
    
    private fun updateNotification(secondsRemaining: Int) {
        val notification = getNotification(secondsRemaining)
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.notify(1, notification)
    }

    private fun getNotification(secondsRemaining: Int): Notification {
        val channelId = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel("my_service", "My Background Service")
        } else {
            ""
        }
    
        // Create an intent that will open your main activity
        val intent = Intent(this, MainActivity::class.java)  // Replace 'MainActivity' with your activity class
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    
        return NotificationCompat.Builder(this, channelId).apply {
            setContentTitle("Timer Running")
            setContentText("Time remaining: ${formatTime(secondsRemaining)}")
            setSmallIcon(R.mipmap.ic_launcher)
            // Attach the pending intent to the notification
            setContentIntent(pendingIntent)
            // Automatically remove the notification when it is clicked
            setAutoCancel(true)
            // Explicitly make the notification silent
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                setSilent(true)
            } else {
                setSound(null)
            }
        }.build()
    }
    

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun createNotificationChannel(channelId: String, channelName: String): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_DEFAULT).apply {
                setSound(null, null)  // Disable sound for the channel
                lockscreenVisibility = Notification.VISIBILITY_PRIVATE
            }
            val notificationManager: NotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
        return channelId
    }

    private fun formatTime(secondsRemaining: Int): String {
        val hours = secondsRemaining / 3600
        val minutes = (secondsRemaining % 3600) / 60
        val seconds = secondsRemaining % 60
    
        // Format time based on the duration
        return if (hours > 0) {
            // Hours are present, use HH:MM:SS format
            String.format("%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            // No hours, use MM:SS format
            String.format("%02d:%02d", minutes, seconds)
        }
    }
}