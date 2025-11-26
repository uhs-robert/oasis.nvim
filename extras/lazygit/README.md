# Lazygit Setup

1. Choose the theme you want
2. Paste the contents into your theme section in `~/.config/lazygit/config.yml`

    **Example:**
    <details>
        <summary>config.yml</summary>

        ```yaml
        gui:
          theme:
            activeBorderColor:
              - "#FFA247"
              - bold
            inactiveBorderColor:
              - "#3DB5FF"
            optionsTextColor:
              - "#F0E68C"
            selectedLineBgColor:
              - "#1A283F"
            cherryPickedCommitBgColor:
              - "#22385C"
            cherryPickedCommitFgColor:
              - "#3DB5FF"
            unstagedChangesColor:
              - "#D06666"
            defaultFgColor:
              - "#D9E6FA"
            searchingActiveBorderColor:
              - "#5A3824"

          authorColors:
            "*": "#FFA247"
        ```
        </details>

3. Close and re-open lazygit to see the theme

> [!NOTE]
> Lazygit uses your terminal background.
>
> You should set it to the relevant background for your theme.
