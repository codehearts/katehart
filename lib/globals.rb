# Global site configuration variables

$contact_info = ['email', 'github', 'resume']

#$cdn              = 'http://cdn.staging.iamnatehart.com/'
$cdn              = 'cdn/'
$js_dir           = $cdn + 'js/'
$css_dir          = $cdn + 'css/'
$images           = $cdn + 'images/'
$profile_images   = $images + 'profile/'
$portfolio_images = $images + 'portfolio/'

$partial_layouts     = '/partials/'
$profile_layouts     = $partial_layouts + 'profiles/'
$portfolio_layouts   = $partial_layouts + 'portfolio/'
$in_progress_layouts = $portfolio_layouts + 'in-progress/'
$scraps_layouts      = $portfolio_layouts + 'scraps/'

$layouts = {
  'portfolio entry' => $portfolio_layouts + 'entry.html'
}
