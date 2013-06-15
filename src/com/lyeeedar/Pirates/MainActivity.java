package com.lyeeedar.Pirates;

import android.os.Bundle;

import com.Lyeeedar.Pirates.GLOBALS;
import com.Lyeeedar.Pirates.PirateGame;
import com.badlogic.gdx.backends.android.AndroidApplication;
import com.badlogic.gdx.backends.android.AndroidApplicationConfiguration;

public class MainActivity extends AndroidApplication {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        AndroidApplicationConfiguration cfg = new AndroidApplicationConfiguration();
        cfg.useGL20 = true;
        cfg.numSamples = 2;
        
        GLOBALS.ANDROID = true;
        
        initialize(new PirateGame(), cfg);
    }
}