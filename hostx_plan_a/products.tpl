<!-- Product Recommendations CSS -->
<link type="text/css" rel="stylesheet" href="{$BASE_PATH_CSS}/recommendations.min.css" property="stylesheet" />
<!-- Core CSS -->
<link rel="stylesheet" type="text/css" href="{assetPath file="style.css"}" property="stylesheet" />
<script>
    jQuery(document).ready(function() {
        jQuery('#btnShowSidebar').click(function() {
            if (jQuery(".product-selection-sidebar").is(":visible")) {
                jQuery('.row-product-selection').css('left', '0');
                jQuery('.product-selection-sidebar').fadeOut();
                jQuery('#btnShowSidebar').html('<i class="fas fa-arrow-circle-right"></i> {$LANG.showMenu}');
            } else {
                jQuery('.product-selection-sidebar').fadeIn();
                jQuery('.row-product-selection').css('left', '300px');
                jQuery('#btnShowSidebar').html('<i class="fas fa-arrow-circle-left"></i> {$LANG.hideMenu}');
            }
        });
    });
</script>

{if $showSidebarToggle}
    <button type="button" class="theme-btn --fill-primary --btn-size-sm --shadow-off" id="btnShowSidebar" data-gap-x="10px">
        <i class="fas fa-arrow-circle-right"></i>
        {$LANG.showMenu}
    </button>
{/if}

<div class="row row-product-selection">
    <div class="col-md-3 sidebar product-selection-sidebar" id="premiumComparisonSidebar">
        {include file="orderforms/standard_cart/sidebar-categories.tpl"}
    </div>
    <div class="col-md-12">

        <div id="hostx-plan-a">
            <div class="main-container price-01">
                <div class="products-headline">
                    <h3 class="title-1">
                        {if $productGroup.headline}
                            {$productGroup.headline}
                        {else}
                            {$productGroup.name}
                        {/if}
                    </h3>
                    {if $productGroup.tagline}
                        <h5 class="title-2">
                            {$productGroup.tagline}
                        </h5>
                    {/if}
                    {if $errormessage}
                        <div class="alert alert-danger">
                            {$errormessage}
                        </div>
                    {elseif !$productGroup}
                        <div class="alert alert-info">
                            {lang key='orderForm.selectCategory'}
                        </div>
                    {/if}
                </div>
                <div id="products" class="price-table-container">
                    <!-- row -->
                    <div class="row justify-content-center" data-gap-y="30px">
                        {* assign value to change icons *}
                        {assign var='counter' value=1}
                        {foreach $products as $product}
                            {$idPrefix = ($product.bid) ? ("bundle"|cat:$product.bid) : ("product"|cat:$product.pid)}
                            {* col *}
                            <div class="col-xl-3 col-md-6" id="{$idPrefix}">
                                {* price-table *}
                                <div class="hostx-plan-a">
                                    {if $product.isFeatured}
                                        {* popular-box *}
                                        <div class="popular-box">
                                            <img src="{$WEB_ROOT}/templates/hostx_whmcs/images/icons/trending-dark.png" class="img-fluid" alt="icon">
                                        </div>
                                    {/if}
                                    <!-- plan-icon -->
                                    <div class="plan-icon">
                                        <img src="{$WEB_ROOT}/templates/hostx_whmcs/images/icons/diamond-0{if $counter == 1}1{elseif $counter == 2}2{elseif $counter == 3}3{elseif $counter == 4}4{/if}.png" class="img-fluid" alt="icon">
                                    </div>
                                    <!-- plan-head -->
                                    <div class="plan-head">
                                        <!-- plan-name -->
                                        <h3 class="plan-name" id="{$idPrefix}-name">{$product.name}</h3>
                                        <!-- plan-para -->
                                        {if $product.tagLine}
                                            <p id="{$idPrefix}-tag-line" class="plan-para">{$product.tagLine}</p>
                                        {/if}
                                    </div>
                                    <!-- plan-price -->
                                    <div class="plan-price">
                                        <!-- price -->
                                        <h4 class="price" id="{$idPrefix}-price">
                                            {if $product.bid}
                                                {$LANG.bundledeal}
                                                {if $product.displayprice}
                                                    <br /><br /><span>{$product.displayPriceSimple}</span>
                                                {/if}
                                            {elseif $product.paytype eq "free"}
                                                <span>{$LANG.orderfree}</span>
                                            {elseif $product.paytype eq "onetime"}
                                                <span class="text">{$product.pricing.onetime}</span><br />
                                                {$LANG.orderpaymenttermonetime}
                                            {else}
                                                {if $product.pricing.hasconfigoptions}
                                                    {$LANG.from}
                                                {/if}
                                                {$product.pricing.minprice.cycleText}
                                                <br>
                                                {if $product.pricing.minprice.setupFee}
                                                    <small>{$product.pricing.minprice.setupFee->toPrefixed()}
                                                        {$LANG.ordersetupfee}</small>
                                                {/if}
                                            {/if}
                                        </h4>
                                    </div>
                                    <!-- actions -->
                                    <div class="actions">
                                        {if $product.qty eq "0"}
                                            <span id="{$idPrefix}-unavailable" class="order-button unavailable">{$LANG.outofstock}</span>
                                        {else}
                                            <a href="{$product.productUrl}" class="theme-btn --fill-primary --has-icon w-100" id="{$idPrefix}-order-button">
                                                {if $product.hasRecommendations} data-has-recommendations="1"{/if}
                                                {$LANG.ordernowbutton}
                                            </a>
                                        {/if}
                                    </div>
                                    <!-- group -->
                                    <div class="group">
                                        <!-- title-4 -->
                                        <h4 class="title-4">Top Features</h4>
                                        <!-- list -->
                                        <ul class="list list-unstyled">
                                            {foreach $product.features as $feature => $value}
                                                <li id="{$idPrefix}-feature{$value@iteration}">
                                                    <img src="{$WEB_ROOT}/templates/hostx_whmcs/images/icons/check-circle.svg" class="img-fluid" alt="icon">
                                                    {$value} {$feature}
                                                </li>
                                            {foreachelse}
                                                {assign var="descriptionLines" value=explode("\n", $product.description)}
                                                {foreach $descriptionLines as $line}
                                                    <li>
                                                        <img src="{$WEB_ROOT}/templates/hostx_whmcs/images/icons/check-circle.svg" class="img-fluid" alt="icon">
                                                        {$line}
                                                    </li>
                                                {/foreach}
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            {* assign to add one for each box value *}
                            {assign var='counter' value=$counter+1}
                        {/foreach}
                    </div>
                </div>
            </div>
            {if count($productGroup.features) > 0}
                <div class="se-footer" data-gap-y="10px">
                    <div class="se-footer-title text-center">{$LANG.orderForm.includedWithPlans}</div>
                    <div class="d-flex align-items-center justify-content-center flex-wrap" data-gap-y="10px">
                    {foreach $productGroup.features as $features}
                        <!-- line -->
                        <div class="line d-flex align-items-center justify-content-start">
                            <img src="{$WEB_ROOT}/templates/hostx_whmcs/images/icons/check-circle.svg" class="icon img-fluid" alt="asd">
                            <span class="text">{$features.feature}</span>
                        </div>
                    {/foreach}
                    </div>
                </div>
            {/if}
        </div>

    </div>
</div>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}

<script src="{$BASE_PATH_JS}/whmcs/recommendations.min.js"></script>