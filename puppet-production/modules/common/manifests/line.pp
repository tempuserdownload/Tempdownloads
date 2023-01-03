# Definition: common::line
#
# When '$ensure == absent', any '~' characters in the line need to be escaped
# This should probably be done here

define common::line($file, $line, $ensure = 'present', $match = undef) {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {

            # With $match, partial matching is possible. This allows you to
            # add a line to a file, unless /part of/ the line is already
            # present. This needs grep without '-x' (--line-regexp).
            if $match == undef {
                $grepfor = $line
                $grepopt = '-qFx'
            }
            else {
                $grepfor = $match
                $grepopt = '-qF'
            }

            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep ${grepopt} -- '${grepfor}' '${file}'",
            }
        }
        absent: {
            exec { "/bin/sed -i '\\~^${line}$~d' '${file}'":
                onlyif => "/bin/grep -qFx -- '${line}' '${file}'",
            }
        }
    }
}
