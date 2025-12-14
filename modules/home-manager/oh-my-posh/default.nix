{ pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      final_space = true;
      version = 3;

      blocks = [
        {
          alignment = "left";
          type = "prompt";
          segments = [
            {
              background = "transparent";
              foreground = "blue";
              style = "plain";
              template = "{{ .Path }}";
              type = "path";
              properties = {
                cache_duration = "none";
                style = "full";
              };
            }
            {
              background = "transparent";
              foreground = "p:grey";
              style = "plain";
              template = " ({{ if ge (len .HEAD) 40 }}{{ .HEAD | trunc 40 }}...{{ else }}{{ .HEAD }}{{ end }})";
              type = "git";
              properties = {
                branch_icon = "";
                cache_duration = "none";
                commit_icon = "@";
                fetch_status = true;
              };
            }
            {
              background = "transparent";
              foreground = "cyan";
              style = "plain";
              template = "{{ if ne .Type \"unknown\"}} - via  Nix{{end}}";
              type = "nix-shell";
            }
          ];
        }

        {
          alignment = "right";
          type = "prompt";
          segments = [
            {
              foreground = "#ffffff";
              style = "plain";
              template = "<green>  {{ .Output }}</green>";
              type = "command";
              properties = {
                shell = "bash";
                command = ./display_node.sh;
              };
            }
            {
              foreground = "#ffffff";
              style = "plain";
              template = "<white> {{ if ne .Segment.Index 0 }} | {{end}}</white><cyan> {{.Output}}</cyan>";
              type = "command";
              properties = {
                shell = "bash";
                command = ./display_terraform.sh;
              };
            }
          ];
        }

        {
          alignment = "left";
          newline = true;
          type = "prompt";
          segments = [
            {
              background = "transparent";
              foreground = "magenta";
              style = "plain";
              template = "{{ if gt .Code 0 }}<red>❯</red>{{else}}<magenta>❯</magenta>{{end}}";
              type = "text";
              properties = {
                cache_duration = "none";
              };
            }
          ];
        }

        {
          alignment = "right";
          type = "rprompt";
          segments = [
            {
              background = "transparent";
              foreground = "yellow";
              style = "plain";
              template = "{{ .FormattedMs }}";
              type = "executiontime";
              properties = {
                cache_duration = "none";
                threshold = 1000;
              };
            }
          ];
        }
      ];

      tooltips = [
        {
          foreground = "#e0af68";
          style = "plain";
          template = "{{if .Profile}} {{.Profile}}{{if .Region}}@{{.Region}}{{end}}{{end}}";
          tips = [
            "aws"
            "terraform"
          ];
          type = "aws";
          properties = {
            display_default = false;
          };
        }
      ];

      secondary_prompt = {
        background = "transparent";
        foreground = "magenta";
        template = "❯❯ ";
      };
    };
  };
}
