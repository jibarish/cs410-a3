# This script depends on:
#
#       * UnicodeData.txt
#         http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
#
#       * NameAliases.txt
#         http://www.unicode.org/Public/UCD/latest/ucd/NameAliases.txt
#
# It outputs a file that, like UnicodeData.txt, consists of lines containing
# fields terminated by semicolons. Each line represents the data for one encoded
# character in the Unicode Standard. Fields for each data entry are:
#
#       0: codepoint
#       1: name (Unicode 3.0 unless control char, in which case verbose alias)
#       2: first letter of general category
#       3: general category
#       4: abbreviation alias (could be blank)
#       5: alternate alias (could be blank)
#       6: correction alias (could be blank)
#       7: figment alias (could be blank)
#

class UnicodeCharacter:
    def __init__(self, codepoint, name, major_category, minor_category, \
                    abbreviation="", alternate="", correction="", figment=""):
        self.codepoint = codepoint
        self.name = name
        self.major_category = major_category
        self.minor_category = minor_category
        self.abbreviation = abbreviation
        self.alternate = alternate
        self.correction = correction
        self.figment = figment

class UnicodeAlias:
    def __init__(self, codepoint, alias, t):
        self.codepoint = codepoint
        self.alias = alias
        self.type = t

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# Get primary data
f = open('UnicodeData.txt', 'r')
unicode_characters = []
for each in f:
    data = each.rstrip().split(';')
    unicode_characters.append(UnicodeCharacter(data[0], data[1], data[2][0], data[2]))
        # Major category is first letter of general category
f.close()

# Get aliases
f = open('NameAliases.txt', 'r')
aliases = []
for each in f:
    if each[0] != "#" and each[0] != "\n":
        data = each.rstrip().split(';')
        aliases.append(UnicodeAlias(data[0], data[1], data[2]))
f.close()

# The only non-unique Unicode 3.0 names are ASCII control chars,
# named "<control>".  Instead use their verbose aliases.
alias_found = False
for uchar in unicode_characters:
    if uchar.name == "<control>":
        for alias in aliases:
            if alias.codepoint == uchar.codepoint:
                uchar.name = alias.alias
                alias_found = True
                break
        if alias_found == False:
            print ("No alias for control char: " + uchar.codepoint)
        alias_found = False

# Add abbreviations, alternates, corrections and figments from aliases
for alias in aliases:
    if alias.type == "abbreviation":
        for uchar in unicode_characters:
            if alias.codepoint == uchar.codepoint:
                uchar.abbreviation = alias.alias
                break
    if alias.type == "alternate":
        for uchar in unicode_characters:
            if alias.codepoint == uchar.codepoint:
                uchar.alternate = alias.alias
                break
    if alias.type == "correction":
        for uchar in unicode_characters:
            if alias.codepoint == uchar.codepoint:
                uchar.correction = alias.alias
                break
    if alias.type == "figment":
        for uchar in unicode_characters:
            if alias.codepoint == uchar.codepoint:
                uchar.figment = alias.alias
                break

# Write out
f = open('unicode_data_clean.txt', 'w')
for uchar in unicode_characters:
    f.write(uchar.codepoint + ';' + uchar.name + ';' + uchar.major_category + ';' \
        + uchar.minor_category + ';' + uchar.abbreviation + ';' + uchar.alternate + ';' \
        + uchar.correction + ';' + uchar.figment + '\n')
f.close()

# -------------------------- DEBUG --------------------------
# names = []
# for each in unicode_characters:
#     names.append(each.name)

# names_asset = set(names)

# diff = len(names) - len(names_asset)
# print ("set length: " + str(len(names_asset)) + "\n" \
#     + "array length: " + str(len(names)) + "\n" \
#     + "repeats: " + str(diff) + "\n")
# -----------------------------------------------------------
