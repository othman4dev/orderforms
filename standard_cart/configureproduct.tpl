{include file="orderforms/standard_cart/common.tpl"}

<script>
var _localLang = {
    'addToCart': '{$LANG.orderForm.addToCart|escape}',
    'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
}
</script>

<div id="order-standard_cart">

    <div class="row">
        <div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>
        <div class="cart-body">

            <div class="header-lined">
                <h1 class="font-size-36">{$LANG.orderconfigure}</h1>
            </div>

            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <form id="frmConfigureProduct">
                <input type="hidden" name="configure" value="true" />
                <input type="hidden" name="i" value="{$i}" />

                <div class="row">
                    <div class="secondary-cart-body">

                        <p>{$LANG.orderForm.configureDesiredOptions}</p>

                        <div class="product-info" style="background-color:#141526;">
                            <p class="product-title" style="color:#fff;margin-bottom:7px">{$productinfo.name}</p>
                            <p style="color:#fff;margin:0;">{$productinfo.description}</p>
                        </div>

                        <div class="alert alert-danger w-hidden" role="alert" id="containerProductValidationErrors">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul id="containerProductValidationErrorsList"></ul>
                        </div>

                        {if $pricing.type eq "recurring"}
                            <div class="field-container">
                                <div class="form-group">
                                    <label for="inputBillingcycle" style="font-size:1.4em">{$LANG.cartchoosecycle}</label>
                                    <div class="newBillingCycle">
                                      {if $pricing.monthly}
                                      <div class="billingcycle" onclick="changeBillingCycle('monthly',this)">
                                        <h1 class="billing-title">Monthly</h1>
                                        <p class="billing-price">€{$pricing.rawpricing.monthly}</p>
                                      </div>
                                      {/if}
                                      {if $pricing.quarterly}
                                      <div class="billingcycle" onclick="changeBillingCycle('quarterly',this)">
                                        <h1 class="billing-title">Quarterly</h1>
                                        <p class="billing-price">€{$pricing.rawpricing.quarterly}</p>
                                        <div class="saving">
                                          <p class="saving-title">Save 5%</p>
                                          <span class="old-price">
                                            €{$pricing.rawpricing.quarterly * 1.20}
                                          </span>
                                        </div>
                                      </div>
                                      {/if}
                                      {if $pricing.semiannually}
                                         <div class="billingcycle" onclick="changeBillingCycle('semiannually',this)">
                                              <h1 class="billing-title">Semiannually</h1>
                                              <p class="billing-price">€{$pricing.rawpricing.semiannually}</p>
                                              <div class="saving">
                                                  <p class="saving-title">Save 10%</p>
                                                  <span class="old-price">
                                                        €{$pricing.rawpricing.semiannually * 1.20}
                                                  </span>
                                              </div>
                                          </div>
                                      {/if}
                                      {if $pricing.annually}
                                          <div class="billingcycle" onclick="changeBillingCycle('annually',this)">
                                              <h1 class="billing-title">Annually</h1>
                                              <p class="billing-price">€{$pricing.rawpricing.annually}</p>
                                              <div class="saving">
                                                  <p class="saving-title">Save 15%</p>
                                                  <span class="old-price">
                                                    €{$pricing.rawpricing.annually * 1.20}
                                                  </span>
                                              </div>
                                          </div>
                                      {/if}
                                    </div>
                                    <select name="billingcycle" id="inputBillingcycle" style="display:none;" class="form-control select-inline custom-select" onchange="updateConfigurableOptions({$i}, this.value); return false">
                                        {if $pricing.monthly}
                                            <option value="monthly"{if $billingcycle eq "monthly"} selected{/if}>
                                                {$pricing.monthly}
                                            </option>
                                        {/if}
                                        {if $pricing.quarterly}
                                            <option value="quarterly"{if $billingcycle eq "quarterly"} selected{/if}>
                                                {$pricing.quarterly}
                                            </option>
                                        {/if}
                                        {if $pricing.semiannually}
                                            <option value="semiannually"{if $billingcycle eq "semiannually"} selected{/if}>
                                                {$pricing.semiannually}
                                            </option>
                                        {/if}
                                        {if $pricing.annually}
                                            <option value="annually"{if $billingcycle eq "annually"} selected{/if}>
                                                {$pricing.annually}
                                            </option>
                                        {/if}
                                        {if $pricing.biennially}
                                            <option value="biennially"{if $billingcycle eq "biennially"} selected{/if}>
                                                {$pricing.biennially}
                                            </option>
                                        {/if}
                                        {if $pricing.triennially}
                                            <option value="triennially"{if $billingcycle eq "triennially"} selected{/if}>
                                                {$pricing.triennially}
                                            </option>
                                        {/if}
                                    </select>
                                </div>
                            </div>
                        {/if}

                        {if count($metrics) > 0}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.metrics.title}</span>
                            </div>

                            <p>{$LANG.metrics.explanation}</p>

                            <ul>
                                {foreach $metrics as $metric}
                                    <li>
                                        {$metric.displayName}
                                        -
                                        {if count($metric.pricing) > 1}
                                            {$LANG.metrics.startingFrom} {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modalMetricPricing-{$metric.systemName}">
                                                {$LANG.metrics.viewPricing}
                                            </button>
                                        {elseif count($metric.pricing) == 1}
                                            {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            {if $metric.includedQuantity > 0} ({$metric.includedQuantity} {$LANG.metrics.includedNotCounted}){/if}
                                        {/if}
                                        {include file="$template/usagebillingpricing.tpl"}
                                    </li>
                                {/foreach}
                            </ul>

                            <br>
                        {/if}

                        {if $productinfo.type eq "server"}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.cartconfigserver}</span>
                            </div>

                            <div class="field-container">

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputHostname">{$LANG.serverhostname}</label>
                                            <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.example.com">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                            <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="{$server.rootpw}">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                            <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="{$server.ns1prefix}" placeholder="ns1">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                            <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="{$server.ns2prefix}" placeholder="ns2">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        {/if}

                        {if $configurableoptions}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.orderconfigpackage}</span>
                            </div>
                            <div class="product-configurable-options" id="productConfigurableOptions">
                                <div class="row">
                                    {foreach $configurableoptions as $num => $configoption}
                                    {if $configoption.optiontype eq 1}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                <select name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" class="form-control">
                                                    {foreach key=num2 item=options from=$configoption.options}
                                                        <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>
                                                            {$options.name}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 2}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                {foreach key=num2 item=options from=$configoption.options}
                                                    <br />
                                                    <label>
                                                        <input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if} />
                                                        {if $options.name}
                                                            {$options.name}
                                                        {else}
                                                            {$LANG.enable}
                                                        {/if}
                                                    </label>
                                                {/foreach}
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 3}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                <br />
                                                <label>
                                                    <input type="checkbox" name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" value="1"{if $configoption.selectedqty} checked{/if} />
                                                    {if $configoption.options.0.name}
                                                        {$configoption.options.0.name}
                                                    {else}
                                                        {$LANG.enable}
                                                    {/if}
                                                </label>
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 4}
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                {if $configoption.qtymaximum}
                                                {if !$rangesliderincluded}
                                                    <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                    {assign var='rangesliderincluded' value=true}
                                                {/if}
                                                    <input type="text" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" class="form-control" />
                                                    <script>
                                                        var sliderTimeoutId = null;
                                                        var sliderRangeDifference = {$configoption.qtymaximum} - {$configoption.qtyminimum};
                                                        // The largest size that looks nice on most screens.
                                                        var sliderStepThreshold = 25;
                                                        // Check if there are too many to display individually.
                                                        var setLargerMarkers = sliderRangeDifference > sliderStepThreshold;

                                                        jQuery("#inputConfigOption{$configoption.id}").ionRangeSlider({
                                                            min: {$configoption.qtyminimum},
                                                            max: {$configoption.qtymaximum},
                                                            grid: true,
                                                            grid_snap: setLargerMarkers ? false : true,
                                                            onChange: function() {
                                                                if (sliderTimeoutId) {
                                                                    clearTimeout(sliderTimeoutId);
                                                                }

                                                                sliderTimeoutId = setTimeout(function() {
                                                                    sliderTimeoutId = null;
                                                                    recalctotals();
                                                                }, 250);
                                                            }
                                                        });
                                                    </script>
                                                {else}
                                                    <div>
                                                        <input type="number" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" min="{$configoption.qtyminimum}" onchange="recalctotals()" onkeyup="recalctotals()" class="form-control form-control-qty" />
                                                        <span class="form-control-static form-control-static-inline">
                                                                x {$configoption.options.0.name}
                                                            </span>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    {/if}
                                    {if $num % 2 != 0}
                                </div>
                                <div class="row">
                                    {/if}
                                    {/foreach}
                                </div>
                            </div>

                        {/if}

                        {if $customfields}

                            <div class="sub-heading pb-1">
                                <span class="primary-bg-color">{$LANG.orderadditionalrequiredinfo}<br><i><small>{lang key='orderForm.requiredField'}</small></i></span>
                            </div>

                            <div class="field-container">
                                {foreach $customfields as $customfield}
                                    <div class="form-group">
                                        <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                        {$customfield.input}
                                        {if $customfield.description}
                                            <span class="field-help-text">
                                                {$customfield.description}
                                            </span>
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>

                        {/if}

                        {if $addons || count($addonsPromoOutput) > 0}

                            <div id="productAddonsContainer">
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.cartavailableaddons}</span>
                                </div>

                                {foreach $addonsPromoOutput as $output}
                                    <div>
                                        {$output}
                                    </div>
                                {/foreach}

                                <div class="row addon-products">
                                    {foreach $addons as $addon}
                                        <div class="col-sm-{if count($addons) > 1}6{else}12{/if}">
                                            <div class="panel card panel-default panel-addon{if $addon.status} panel-addon-selected{/if}">
                                                <div class="panel-body card-body">
                                                    <label>
                                                        <input type="checkbox" name="addons[{$addon.id}]"{if $addon.status} checked{/if} />
                                                        {$addon.name}
                                                    </label><br />
                                                    {$addon.description}
                                                </div>
                                                <div class="panel-price">
                                                    {$addon.pricing}
                                                </div>
                                                <div class="panel-add">
                                                    <i class="fas fa-plus"></i>
                                                    {$LANG.addtocart}
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}
                        <div class="alert alert-warning info-text-sm">
                            <i class="fas fa-question-circle"></i>
                            {$LANG.orderForm.haveQuestionsContact} <a href="{$WEB_ROOT}/contact.php" target="_blank" class="alert-link">{$LANG.orderForm.haveQuestionsClickHere}</a>
                        </div>
                    </div>
                    <div class="secondary-cart-sidebar" id="scrollingPanelContainer">
                        <div id="orderSummary">
                            <div class="order-summary">
                                <div class="loader" id="orderSummaryLoader">
                                    <i class="fas fa-fw fa-sync fa-spin"></i>
                                </div>
                                <h2 class="font-size-30">{$LANG.ordersummary}</h2>
                                <div class="summary-container" id="producttotal"></div>
                            </div>
                            <div class="text-center">
                                <button type="submit" id="btnCompleteProductConfig" class="btn btn-primary btn-lg">
                                    {$LANG.continue}
                                    <i class="fas fa-arrow-circle-right"></i>
                                </button>
                            </div>
                        </div>

                    </div>

                </div>

            </form>
        </div>
    </div>
</div>

<script>recalctotals();</script>

<style>
.saving {
  display: flex;
  align-items: center;
  gap: 5px;
}
.newBillingCycle {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
}
.billingcycle {
  border-style: solid;
  border-width: 2.5px;
  border-color: #141526;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 10px;
  gap: 5px;
  border-radius: 8px;
  background-color: #141526;
  color: #fff;
  padding: 15px;
  min-width: 220px;
  min-height: 120px;
  cursor: pointer;
  transition: 0.2s;
}
.billingcycle:hover {
  background-color: #1a1c31;
}
.billing-title {
  margin: 0;
  font-size: 20px;
  font-weight: bold;
}
.billing-price {
  margin: 0;
}
.saving-title {
  margin: 0;
  background-color: #1d24ca;
  padding: 5px;
  border-radius: 100px;
  font-size: 13px;
  margin-top: 2px;
  color:#fff;
}
.old-price {
  text-decoration: line-through;
  color: #787878;
  font-size: 13px;
}
.active- {
  border-color: #1d24ca;
}
#order-standard_cart .order-summary h2 {
  padding: 12px 10px;
  color: #fff;
  text-align: center;
  font-size: 16px;
  font-weight: 500;
  background-color: #1D24CA;
  margin: 0;
}
#order-standard_cart .summary-container {
  margin: 0;
  padding: 10px;
  min-height: 100px;
  background-color: #141526;
  color: #fff;
  font-size: 0.8em;
}

#order-standard_cart .order-summary .product-name {
  display: block;
  font-weight: bold;
  font-size: 1.4em;
  color: #fff;
}
#order-standard_cart .order-summary .product-group {
  margin: 0 0 5px 0;
  display: block;
  font-style: italic;
  font-size: 1.4em;
}
#order-standard_cart .order-summary .summary-totals {
  margin: 5px 0;
  padding: 5px 0;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  font-size: 1.3em;
}
#btnCompleteProductConfig {
    background-color: #1D24CA;
}

#order-standard_cart .product-info .product-title {
  margin: 0;
  font-size: 1.8em;
}

</style>

<script>

        function changeBillingCycle(choice,el) {
            console.log(choice);
          let select = document.getElementById("inputBillingcycle");
          console.log(select);
          select.querySelectorAll("option").forEach(function (el) {
            el.removeAttribute("selected");
          });
          select
            .querySelector('option[value="' + choice + '"]')
            .setAttribute("selected", "selected");
          document.querySelectorAll(".active-").forEach(function (el) {
            el.classList.remove("active-");
          });
          if (choice == "monthly") {
            el.classList.add("active-");
          } else if (choice == "quarterly") {
            el.classList.add("active-");
          } else if (choice == "semiannually") {
            el.classList.add("active-");
          } else {
            el.classList.add("active-");
          }
          updateConfigurableOptions(0, select.querySelector('option[value="' + choice + '"]').value);
        }

</script>


{include file="orderforms/standard_cart/recommendations-modal.tpl"}
