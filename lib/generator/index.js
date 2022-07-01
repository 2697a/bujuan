const lodash = require('lodash')
const converter = require('number-to-words')
const fs = require('fs')
const opentype = require('opentype.js')

function _capitalizeFirstLetter (string) {
    return string.charAt(0).toUpperCase() + string.slice(1)
}

function _getIconName (name) {
    const camelCasedName = lodash.camelCase(name)
    const numberFromCamelCaseName = camelCasedName.replace(/[^\d].*/, '')
    if (numberFromCamelCaseName !== '') {
        const wordForNumber = converter.toWords(numberFromCamelCaseName)
        const camelCasedWord = lodash.camelCase(wordForNumber)

        const variableName = camelCasedWord + _capitalizeFirstLetter(camelCasedName.replace(numberFromCamelCaseName, ''))
        return variableName
    }

    return camelCasedName
}

function TablerIconsTemplateDart (icons) {
    const validIcons = icons
        .filter((eachIcon) => !!eachIcon.unicode)
        .map((eachIcon) => {
            if (eachIcon.name === 'switch') {
                return {
                    ...eachIcon,
                    name: 'switchIcon'
                }
            }
            return eachIcon
        })

    const iconStaticVariables = validIcons.map((eachIcon) => {
        return `  static const IconData ${_getIconName(eachIcon.name)} = IconData(${eachIcon.unicode}, fontFamily: 'tabler-icons', fontPackage: "tabler_icons");`
    })

    const listOfIcons = validIcons.map((eachIcon) => {
        return `            TablerIcon("${eachIcon.name}", TablerIcons.${_getIconName(eachIcon.name)})`
    })

    return `
library tabler_icons;

import 'package:flutter/widgets.dart';

class TablerIcon {
    final String name;
    final IconData icon;

    TablerIcon(this.name, this.icon);
}

class TablerIcons {
  TablerIcons._();

  ${iconStaticVariables.join('\n')}

  static List<TablerIcon> get iconList {
    return [
      ${listOfIcons.join(',\n')}
    ];
  }
}
`
}

(async () => {
    const font = await opentype.load('../assets/fonts/v1.68.0.ttf')
    const glyphs = Object.values(font.glyphs.glyphs)
    const icons = glyphs.map(eachGlyph => ({
        name: eachGlyph.name,
        unicode: eachGlyph.unicode
    }))

    const dartIconFileString = TablerIconsTemplateDart(icons)
    fs.writeFileSync('../lib/tabler_icons.dart', dartIconFileString, 'utf-8')
})()
