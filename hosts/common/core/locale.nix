{ configVars, ... }: {

  # Set your time zone.
  time.timeZone = configVars.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = configVars.encoding;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = configVars.encoding;
    LC_IDENTIFICATION = configVars.encoding;
    LC_MEASUREMENT = configVars.encoding;
    LC_MONETARY = configVars.encoding;
    LC_NAME = configVars.encoding;
    LC_NUMERIC = configVars.encoding;
    LC_PAPER = configVars.encoding;
    LC_TELEPHONE = configVars.encoding;
    LC_TIME = configVars.encoding;
  };
}
