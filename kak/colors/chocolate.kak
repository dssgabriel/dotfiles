# Chocolate colorscheme by snakedye

evaluate-commands %sh{
    gray="rgb:3d3837"
    red="rgb:c65f5f"
    green="rgb:95a882"
    yellow="rgb:d9b27c"
    blue="rgb:728797"
    purple="rgb:998396"
    aqua="rgb:829e9b"
    orange="rgb:d08b65"
    kaki="rgb:86887f"

    bg="rgb:252221"
    bg_alpha="rgba:212020a0"
    bg1="rgb:262322"
    bg2="rgb:302c2b"
    bg3="rgb:3d3837"
    bg4="rgb:413c3a"
    bg5="rgb:615c5a"
    
    fg="rgb:c8baa4"
    fg_alpha="rgba:a59a87a0"
    fg0="rgb:a5a08e"
    fg2="rgb:b7b2a1"
    fg3="rgb:b8abaa"
    fg4="rgb:aca59c"

    echo "
		# Code highlighting
		face global value         ${orange}
        face global type          ${yellow}
        face global variable      ${green}
        face global module        ${green}
        face global function      ${blue}
        face global string        ${green}
        face global keyword       ${red}
        face global operator      ${blue}
        face global attribute     ${aqua}
        face global comment       ${bg4}+i
        face global documentation ${bg5}+b
        face global meta          ${purple}
        face global builtin       ${yellow}+b

        # Markdown highlighting
        face global title     ${green}+b
		face global header    ${orange}
		face global mono      ${fg4}
		face global block     ${green}
		face global link      ${blue}+u
		face global bullet    ${yellow}
		face global list      ${fg}

		face global Default            ${fg},${bg}
		face global PrimarySelection   ${fg_alpha},${blue}+g
		face global SecondarySelection ${bg_alpha},${blue}+g
		face global PrimaryCursor      ${bg},${fg}+fg
		face global SecondaryCursor    ${bg},${bg4}+fg
		face global PrimaryCursorEol   ${bg},${fg4}+fg
		face global SecondaryCursorEol ${bg},${bg2}+fg
		face global LineNumbers        ${bg4}
		face global LineNumberCursor   ${yellow},${bg1}+b
		face global LineNumbersWrapped ${bg2}+i
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
