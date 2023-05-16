package com.walaaCustomer.walaa_customer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;

import android.os.Build;
import android.os.Bundle;
import android.window.SplashScreenView;

import androidx.core.view.WindowCompat;

public class MainActivity extends FlutterActivity {
    @Override
    public SplashScreen provideSplashScreen() {
        return new Splash();
    }
}
