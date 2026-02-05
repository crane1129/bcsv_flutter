import 'package:bcsv_flutter_project/core/storage/secure_storage.dart';
import 'package:bcsv_flutter_project/core/storage/local_storage.dart';
import 'dart:developer';

/// Handles one-time migration of hardcoded credentials to secure storage
class CredentialMigration {
  static const _migrationKey = 'credentials_migrated_v1';

  /// Default credentials for initial migration
  /// SECURITY NOTE: These should be rotated after migration is complete
  /// and new credentials should be fetched from a secure source
  static const _defaultCredentials = {
    "type": "service_account",
    "project_id": "bcsv-mobile-project",
    "private_key_id": "48baad6c4e974b5c1466d8d79be224fe61e87f21",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDTPfqG4xkhae5J\nBIvuH2yhv2rTjLwRwYasT0okUBN58ZcNqBBI1iGo46KLwf2EU4ILzG6/tG5Nt7WC\nQNN9xUM/ECPkEhIq/guoVNvgn34BOVHK1QDZfrnxhTC/+8xfDmeqWsDCpnvE7oOm\nbAU08EVo6fpGRs1UUwnwU6zY2RM5queeMxPBD9r8iHTtFEUnq8pmTFtH0n1aOs5a\nsl1bbNgyL+79MWeXO4OWmW2iQzjw5hwcFuiN6uY58wBLCsYnLXUM9Sqdu7hPifcv\nAWAJDP0tdceSnEoF4kgx0n/K6zgNdS3hZCmCLLUD0W7n2dOYEOFJ7yOKBjlTFcwc\nx07vdIaFAgMBAAECggEALXtOOgWibwnORsVmVW5Jpue+We8WvSH0W5w0w+3Dy8Ei\n+0tAulX0aFces8WgToHmYaDyBW+VQkF4IKPRhWZYDLduatgjNkN9ghBHSS095YiQ\nXkIPTUTWRzScovFVdu/0jP6+Owq6YlPSX54pXtUOtMCP5NqwseOxI5/4erX+SC9q\nP9NXbXbRRmtZloUiBFPjnq0UGg+xUv39fZIdoFMTLcfcFmaxPc0WRgtAHiXJs5WV\nslV5ue1XmVHLP/xrw3Y30KR/zEhR3E53jB/6ffEvOi3YhQESAjF26P/UQM4gy5TG\nK196Lx8lyg/SFtqdru4gWlQImqUlpk1b6h2LsyEZzwKBgQDwAorvk7CvaSvWWysb\na3+6nYXZhQUSR9uKAP5Ug8Idw32G09Sn61TpDzV17zKPM8chsZ31PcqTB88MMMuq\nAgYw5t34VecE2Ql+TEuMGjYryxe0LNLfeR5R8DQXlhexGHb9WwmKhUwwQOnH8mhr\nVr5B418cWk/s2CFdmi+3P2+TbwKBgQDhUMpA9G1RKaJOAFvCc03s9WJfj0yuV0M8\ns8UVvixLAPFrEZcsknMwSwCwVCLV5BFbbOjVkfIyeQ+90vh1XPN23BKP5BAiIUV8\nBcd/Hj4JZIZuIY0XlFAxUegK/ymxeF7nG8OXtfqnjg3B/zx5zFM5rSXsO4AMGjyk\n3+ivEfJ7SwKBgQDtNVYjmpBRjVxqKwjbvM8snWsgpLtyadqs9nZnCSHdUMzLaKkQ\nnSH6hbGMsbACoGX7AxTewQdpcZpMrh1cFUwRINvZCO2eePNNBBLWkUFg3wS6amKv\nw4EX8pNJjGo1+bwAgu1XHo9CUaW8m/RfwgegDxx9ZTUBHEs9u5nVPrkDuQKBgHbo\nBfTFibNdf3QeqE40P5mf3iyEGXmgP7GXRZk15XYnp0BT5i31k6iWzGRB4qhyVd6j\n2TRscx7D2NTas5hsV2gQuBMLzp/UYzESc7fYI/EdBfy05BrfgHqmuQikpEIuPhdF\nBbHYrdEjHIuWwTmd5QX5JJxIwkigyARSzh8mH4uFAoGBAMnlV34V9mugAJ9AD1JL\n8PlKRm25yJJ1ew1ypm3OTxnIaHXyDQi62hLG65OzVsRZ0YW7iZ2CzsUOq4c0J6Rr\nvrTdBvP1fvQobbxE3ohnf+yQPAQ//NdNIy/ctyhn7YxC+EkB4dsgQAmk/I7GKxT6\nDo9TJBz/22Qv7Gd//R/Jz+/t\n-----END PRIVATE KEY-----\n",
    "client_email": "bcsv-mobile@bcsv-mobile-project.iam.gserviceaccount.com",
    "client_id": "100203583150583478933",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bcsv-mobile%40bcsv-mobile-project.iam.gserviceaccount.com"
  };

  static const _defaultSpreadsheetId = '13IJ24036nIXJqFL00wtUBXfGaJJZSWOArYOYutEMeVY';

  /// Run migration if not already done
  /// Returns true if migration was performed, false if already migrated
  static Future<bool> migrateIfNeeded() async {
    final alreadyMigrated = LocalStorage.getBool(_migrationKey) ?? false;

    if (alreadyMigrated) {
      log('Credentials already migrated to secure storage');
      return false;
    }

    try {
      // Check if credentials already exist in secure storage
      final hasCredentials = await SecureStorage.hasGoogleCredentials();

      if (!hasCredentials) {
        // Migrate default credentials to secure storage
        await SecureStorage.storeGoogleCredentials(_defaultCredentials);
        await SecureStorage.storeSpreadsheetId(_defaultSpreadsheetId);
        log('Migrated Google credentials to secure storage');
      }

      // Mark migration as complete
      await LocalStorage.setBool(_migrationKey, true);
      log('Credential migration completed');
      return true;
    } catch (e) {
      log('Credential migration failed: $e');
      return false;
    }
  }

  /// Force re-migration (for debugging/testing)
  static Future<void> resetMigration() async {
    await LocalStorage.remove(_migrationKey);
    await SecureStorage.delete('google_service_credentials');
    await SecureStorage.delete('google_spreadsheet_id');
    log('Migration reset - will re-migrate on next launch');
  }
}
