<link rel="stylesheet" type="text/css" href="{assetPath file='all.css'}?v={$versionHash}" />
{assetExists file="custom.css"}
<link rel="stylesheet" type="text/css" href="{$__assetPath__}?v={$versionHash}" />
{/assetExists}
<script type="text/javascript" src="{assetPath file='scripts.js'}?v={$versionHash}"></script>