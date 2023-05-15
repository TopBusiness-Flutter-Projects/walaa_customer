package com.walaaCustomer.walaa_customer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;

public class MainActivity extends FlutterActivity {
    @Override
    public SplashScreen provideSplashScreen() {
        return new Splash();
    }
}
