package com.walaaCustomer.walaa_customer;

import io.flutter.embedding.android.FlutterActivity;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;

import io.flutter.embedding.android.SplashScreen;

public class Splash implements SplashScreen {

    @Override
    public View createSplashView(Context context, Bundle savedInstanceState) {
        return LayoutInflater.from(context).inflate(R.layout.splash, null, false);
    }

    @Override
    public void transitionToFlutter(Runnable onTransitionComplete) {
        onTransitionComplete.run();
    }
}