{ pkgs }:
{

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "ja_JP.UTF-8/UTF-8"
    ];

  };
}
