node default {
 
  $classes = hiera("include_classes")

  if $classes {
    common::includer { $classes: }
  }
}
