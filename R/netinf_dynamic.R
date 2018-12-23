#' A Function to create estimates for network inference for each year (25 year window)
#'
#' @param data.frame Final dataset used in the project
#' @return data.frame with estimates
#' @export
#'
netinf_dynamic <- function(data, edges=NULL, window=NULL,
                        startYear=NULL, endYear=NULL) {
  if(is.null(edges)) {
    edges = .05
  }

  if(is.null(window)) {
    window = 25
  }

  if(is.null(startYear)) {
    startYear = 1945
  }

  if(is.null(endYear)) {
    endYear = 2017
  }
  #Convert to Cascade Object
  treaty_cascades <- NetworkInference::as_cascade_long(data,
                                     cascade_node_name="cname",
                                     event_time="sign_year2",
                                     cascade_id="title")


  #Save empty object
  estNetDynamicAll <- NULL


  while (startYear + window <= endYear) {
    treaty_cascades <- data %>%
      filter(sign_year2 >= startYear &
               sign_year2 <= startYear + window) %>%
      NetworkInference::as_cascade_long(cascade_node_name="cname",
                      event_time="sign_year2",
                      cascade_id="title")
    treatyDataSubsetNetworkAll <- NetworkInference::netinf(treaty_cascades,
                                         p_value_cutoff = edges)
    estNetDynamicAll <- treatyDataSubsetNetworkAll %>%
      transmute(state_01 = origin_node,
                state_02 = destination_node,
                year = startYear + window,
                lambda = attributes(treatyDataSubsetNetworkAll)$diffusion_model_parameters) %>%
      bind_rows(estNetDynamicAll)
    cat("Just completed year",
        startYear + window,
        "\n")
    startYear = startYear + 1
  }
  return(estNetDynamicAll)
}

