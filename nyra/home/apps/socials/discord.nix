{ config, lib, inputs, ... }: with lib;

let
  cfg = config.nyra.home.apps.socials.discord;
in
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  options.nyra.home.apps.socials.discord = {
    enable = mkEnableOption "discord";
  };

  config = {
    programs.nixcord = {
      enable = cfg.enable;
      discord = {
        enable = true;
        equicord.enable =  true;
        vencord.enable = false;
      };
      config = {
        useQuickCss = false;
        frameless = true;
        transparent = true;
        plugins = {
          #usrbg.enable = true;
          alwaysAnimate.enable = true;
          alwaysTrust.enable = true;
          animalese.enable = true;
          autoDndWhilePlaying.enable = true;
          betterActivities.enable = true;
          betterAudioPlayer.enable = true;
          betterBlockedUsers.enable = true;
          betterCommands.enable = true;
          betterFolders.enable = true;
          betterInvites.enable = true;
          betterRoleContext.enable = true;
          betterSettings.enable = true;
          betterUploadButton.enable = true;
          biggerStreamPreview.enable = true;
          blockKrisp.enable = true;
          channelTabs.enable = true;
          colorSighted.enable = false;
          #commandPalette.enable = true;
          copyFileContents.enable = true;
          copyProfileColors.enable = true;
          customRpc.enable = true; # TODO: Add config
          customSounds.enable = true; # TODO: Add config
          customTimestamps.enable = true;
          customUserColors.enable = false;
          dearrow.enable = true;
          decor.enable = true;
          disableCameras.enable = true;
          disableDeepLinks.enable = true;
          dontRoundMyTimestamps.enable = true;
          equicordHelper = {
            enable = false;
            disableCreateDmButton = true;
            disableDmContextMenu = true;
            noMirroredCamera = true;
            removeActivitySection = true;
          };
          equicordToolbox.enable = true;
          exportMessages.enable = true;
          fakeNitro.enable = true;
          fastDeleteChannels.enable = true;
          #favoriteEmojiFirst.enable = true;
          #favoriteGifSearch.enable = true;
          findReply.enable = true;
          fixFileExtensions.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          followVoiceUser = {
            enable = true;
            onlyWhenInVoice = true;
          };
          fontLoader.enable = true;
          #forceOwnerCrown.enable = true;
          forwardAnywhere.enable = true;
          friendInvites.enable = true;
          friendsSince.enable = true;
          gameActivityToggle.enable = true;
          ghosted = {
            enable = true;
            scary = true;
          };
          gitHubRepos.enable = true;
          globalBadges.enable = true;
          googleThat = {
            enable = true;
            defaultEngine = "DuckDuckGo";
          };
          hideChatButtons.enable = true;
          #holyNotes.enable = true;
          homeTyping.enable = true;
          ignoreTerms.enable = true;
          imageFilename.enable = true;
          imageZoom.enable = true;
          imgToGif.enable = true;
          #jellyfinRichPresence.enable = true;
          jumpscare = {
            enable = true;
            # Maybe set audioSource and imageSource
            chance = 100;
          };
          keepCurrentChannel.enable = true;
          loadingQuotes.enable = true;
          loginWithQr.enable = true;
          memberCount.enable = true;
          messageLinkEmbeds.enable = true;
          messageLogger.enable = true;
          messageTags.enable = true;
          #messageTranslate.enable = true;
          #moreCommands.enable = true;
          moyai = {
            enable = true;
            quality = "HD";
            triggerWhenUnfocused = true;
          };
          musicControls.enable = true;
          newPluginsManager.enable = true;
          noNitroUpsell.enable = true;
          openInApp.enable = true;
          partyMode.enable = true;
          permissionFreeWill.enable = true;
          permissionsViewer.enable = true;
          polishWording = {
            enable = true;
            fixCapitalization = true;
            quickDisable = true;
          };
          previewMessage.enable = true;
          quickMention.enable = true;
          quickThemeSwitcher.enable = true;
          replaceGoogleSearch = {
            enable = true;
            customEngineName = "DuckDuckGo";
            customEngineUrl = "https://www.duckduckgo.com/?q=";
          };
          shikiCodeblocks.enable = true;
          showAllMessageButtons.enable = true;
          showMeYourName.enable = true;
          #snowfall.enable = true;
          splitLargeMessages.enable = true;
          talkInReverse.enable = true;
          #tiktokTts.enable = true;
          unitConverter = {
            enable = true;
            myUnits = "metric";
          };
          userPfp.enable = true;
          videoSpeed.enable = true;
          voiceChatUtilities.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };

    services.mpd-discord-rpc.enable = cfg.enable && config.services.mpd.enable;
  };
}
