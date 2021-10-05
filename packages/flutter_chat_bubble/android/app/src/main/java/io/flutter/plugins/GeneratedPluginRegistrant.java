package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import chat.com.flutter_chat_bubble.FlutterChatBubblePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterChatBubblePlugin.registerWith(registry.registrarFor("chat.com.flutter_chat_bubble.FlutterChatBubblePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
