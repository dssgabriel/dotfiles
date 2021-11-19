# Chocolate colorscheme by snakedye

evaluate-commands %sh{
    gray="rgb:3d3837"
    red="rgb:c65f5f"
    green="rgb:859e82"
    yellow="rgb:d9b27c"
    blue="rgb:728797"
    purple="rgb:998396"
    aqua="rgb:829e9b"
    orange="rgb:d08b65"
    beige="rgb:ab9382"

    bg="rgb:252221"
    bg_alpha="rgba:212020a0"
    bg1="rgb:262322"
    bg2="rgb:302c2b"
    bg3="rgb:3d3837"
    bg4="rgb:413c3a"
    bg5="rgb:615c5a"
    
    fg="rgb:c8baa4"
    fg_alpha="rgba:a59a87a0"
    fg1="rgb:cdc0ad"
    fg2="rgb:beae94"
    fg3="rgb:d1c6b4"

    echo "
		# Code highlighting
		face global value         ${orange}
        face global type          ${yellow}
        face global variable      ${green}
        face global constant      ${beige}
        face global module        ${green}
        face global function      ${blue}
        face global string        ${green}
        face global keyword       ${red}
        face global operator      ${blue}
        face global class         ${yellow}
        face global attribute     ${aqua}
        face global comment       ${bg4}+i
        face global documentation ${bg5}+b
        face global meta          ${purple}
        face global builtin       ${beige}

        # Markdown highlighting
        face global title     ${green}+b
		face global header    ${orange}
		face global mono      ${fg3}
		face global block     ${green}
		face global link      ${blue}+u
		face global bullet    ${yellow}
		face global list      ${fg}

		face global Default            ${fg},${bg}
		face global PrimarySelection   ${fg_alpha},${blue}+g
		face global SecondarySelection ${bg_alpha},${blue}+g
		face global PrimaryCursor      ${bg},${fg}+fg
		face global SecondaryCursor    ${bg},${bg4}+fg
		face global PrimaryCursorEol   ${bg},${fg3}+fg
		face global SecondaryCursorEol ${bg},${bg2}+fg
		face global LineNumbers        ${bg4}
		face global LineNumberCursor   ${yellow},${bg1}+b
		face global LineNumbersWrapped ${bg3}+i
		face global MenuForeground     ${bg},${yellow}
		face global MenuBackground     ${fg},${bg2}
		face global MenuInfo           ${bg}
        face global Information        ${bg},${fg}
        face global Error              ${bg},${red}
        face global StatusLine         ${fg},${bg}
        face global StatusLineMode     ${yellow}+b
        face global StatusLineInfo     ${purple}
        face global StatusLineValue    ${red}
        face global StatusCursor       ${bg},${fg}
        face global Prompt             ${yellow}
        face global MatchingChar       ${fg},${bg3}+b
        face global BufferPadding      ${bg2},${bg}
        face global Whitespace         ${bg2}+f
    "
}
