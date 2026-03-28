{
  config,
  lib,
  pkgs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
  cfg = config.nyra.home.apps.zed;
in
{
  options.nyra.home.apps.zed = {
    enable = lib.mkEnableOption "zed";
  };

  config = {
    programs.zed-editor = {
      enable = cfg.enable;
      mutableUserSettings = false;
      userSettings = {
        agent = {
          favorite_models = [ ];
          model_parameters = [ ];
          enable_feedback = true;
        };

        disable_ai = false;

        git = {
          branch_picker = {
            show_author_name = true;
          };
          blame = {
            show_avatar = true;
          };
          inline_blame = {
            show_commit_summary = false;
            enabled = true;
          };
          git_gutter = "tracked_files";
          disable_git = false;
        };

        active_pane_modifiers = {
          border_size = 0.0;
          inactive_opacity = 0.8;
        };

        window_decorations = "client";

        preview_tabs = {
          enabled = true;
        };

        tabs = {
          show_diagnostics = "all";
          show_close_button = "always";
          close_position = "right";
          file_icons = true;
          git_status = true;
        };

        tab_bar = {
          show_pinned_tabs_in_separate_row = true;
          show_tab_bar_buttons = true;
          show_nav_history_buttons = true;
          show = true;
        };

        title_bar = {
          show_menus = false;
          show_user_picture = true;
          show_user_menu = true;
          show_sign_in = false;
          show_onboarding_banner = false;
          show_project_items = true;
          show_branch_name = true;
          show_branch_icon = true;
        };

        debugger = {
          button = true;
        };

        terminal = {
          toolbar = {
            breadcrumbs = false;
          };
          copy_on_select = false;
          keep_selection_on_copy = true;
          cursor_shape = "bar";
          working_directory = "current_project_directory";
          shell = "system";
          button = true;
        };

        status_bar = {
          cursor_position_button = false;
          active_encoding_button = "non_utf8";
          active_language_button = false;
        };

        project_panel = {
          hide_gitignore = false;
          entry_spacing = "comfortable";
          file_icons = true;
          folder_icons = true;
          git_status = true;
          button = true;
        };

        restore_on_file_reopen = true;
        close_on_file_delete = false;

        file_finder = {
          file_icons = true;
          include_ignored = "smart";
        };

        search = {
          button = true;
          center_on_match = false;
          regex = false;
          include_ignored = false;
          whole_word = true;
        };

        use_smartcase_search = true;
        diagnostics_max_severity = "all";

        diagnostics = {
          button = true;
          lsp_pull_diagnostics = {
            enabled = true;
          };
          include_warnings = true;
          inline = {
            enabled = true;
          };
        };

        prettier = {
          allowed = true;
        };

        completions = {
          lsp_insert_mode = "replace_suffix";
          lsp = true;
        };

        go_to_definition_fallback = "find_all_references";
        linked_edits = true;
        enable_language_server = true;

        indent_guides = {
          active_line_width = 1;
          line_width = 1;
          enabled = true;
        };

        allow_rewrap = "in_comments";
        soft_wrap = "editor_width";

        toolbar = {
          code_actions = false;
          selections_menu = true;
          quick_actions = true;
          breadcrumbs = true;
        };

        minimap = {
          show = "never";
        };

        scrollbar = {
          diagnostics = "all";
          axes = {
            vertical = true;
            horizontal = true;
          };
          selected_symbol = true;
          selected_text = true;
          search_results = true;
          git_diff = true;
          cursors = true;
          show = "auto";
        };

        inline_code_actions = true;
        snippet_sort_order = "inline";
        hover_popover_delay = 300;
        hover_popover_enabled = true;

        drag_and_drop_selection = {
          delay = 300;
          enabled = true;
        };

        relative_line_numbers = "disabled";

        gutter = {
          min_line_number_digits = 4;
          folds = true;
          breakpoints = true;
          runnables = true;
          line_numbers = true;
        };

        show_signature_help_after_edits = false;
        auto_signature_help = false;

        sticky_scroll = {
          enabled = true;
        };

        autoscroll_on_clicks = false;
        horizontal_scroll_margin = 5.0;
        vertical_scroll_margin = 5.0;
        scroll_beyond_last_line = "vertical_scroll_margin";
        diff_view_style = "split";

        which_key = {
          enabled = false;
        };

        autosave = {
          after_delay = {
            milliseconds = 2000;
          };
        };

        helix_mode = false;
        show_wrap_guides = true;
        current_line_highlight = "all";
        selection_highlight = true;
        rounded_selection = true;
        unnecessary_code_fade = 0.3;
        hide_mouse = "on_typing_and_movement";
        cursor_shape = "bar";
        multi_cursor_modifier = "alt";
        cursor_blink = true;
        agent_ui_font_size = 18.0;
        text_rendering_mode = "platform_default";
        buffer_line_height = "comfortable";
        restore_on_startup = "last_session";
        redact_private_values = false;
        use_system_prompts = true;
        use_system_path_prompts = true;
        on_last_window_closed = "quit_app";
        when_closing_with_no_tabs = "keep_window_open";
        vim_mode = false;

        telemetry = {
          diagnostics = true;
          metrics = true;
        };

        session = {
          restore_unsaved_buffers = true;
          trust_all_worktrees = true;
        };

        base_keymap = "JetBrains";

        icon_theme = {
          mode = "system";
          light = "Catppuccin Frappé";
          dark = "Catppuccin Frappé";
        };
        buffer_font_size = lib.mkIf (theme ? zed) (lib.mkForce theme.zed.buffer_font_size);
        ui_font_size = lib.mkIf (theme ? zed) (lib.mkForce theme.zed.ui_font_size);
      };
      extensions = [
        "nix"
        "catppuccin-icons"
        "java"
        "php"
        "toml"
        "sql"
        "csharp"
        "kotlin"
        "markdown-snippets"
        "html-snippets"
        "php-snippets"
        "git-firefly"
        "opencode"
      ];
    };
  };
}
