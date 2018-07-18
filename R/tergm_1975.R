#' A Function to run TERGM for the Cold War years
#'
#' @param data.frame Final dataset used in the project
#' @return data.frame with independent variables for 1975-1989 years, data.frame with netinf estimates
#' @export
#'
tergm_1975 <-function(ivs75, edgelist){
  set.seed(11235)
  edgelist <- subset(edgelist, year>=1975&year<1990)
  # cname that exist in edgelist but not in ivs?
  edgelist_system <- subset(edgelist,(edgelist$state_01 %in% ivs75$cname)&(edgelist$state_02 %in% ivs75$cname))
  net75 <- list()
  for (yr in 1:15) {
    # Subset by year
    dataYr <- subset(ivs75, year==(yr+1974))

    #no nulls
    #dataYr[is.na(dataYr)] <-
    elYr <- subset(edgelist_system, year==(yr+1974))
    elYr$year <- NULL
    elYr$lambda <- NULL


    nv <- nrow(dataYr)

    net75[[yr]] <- network.initialize(nv)

    network.vertex.names(x=net75[[yr]]) <- dataYr$cname

    net75[[yr]][as.matrix(elYr)] <- 1

    #Apply nodal attributes
    set.vertex.attribute(x=net75[[yr]],attrname="major",value=dataYr$major)
    set.vertex.attribute(x=net75[[yr]],attrname="democracy",val=dataYr$democ)
    set.vertex.attribute(x=net75[[yr]],attrname="cinc",value=dataYr$cinc)
    set.vertex.attribute(x=net75[[yr]],attrname="totalpop",value=dataYr$tpop)
    set.vertex.attribute(x=net75[[yr]],attrname="urbanpop",value=dataYr$upop)
    set.vertex.attribute(x=net75[[yr]],attrname="region",value=dataYr$region)

    #Apply edge attributes

    set.network.attribute(x=net75[[yr]], attrname="distance", value=as.matrix(distance75))
    set.network.attribute(x=net75[[yr]], attrname="trade", value=as.matrix(tradelist75[[yr]]))
  }

  ## btergm models

  est1 <- btergm(net75~ edges+
                   mutual +transitive+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance")
                 , R=100)
  est2 <- btergm(net75~ edges+
                   mutual +nodematch("democracy")+nodeocov("democracy")+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance")
                 , R=100)
  est3 <- btergm(net75~ edges+
                   mutual +transitive+nodematch("democracy")+nodeocov("democracy")+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance")
                 , R=100)
  est4 <- btergm(net75~ edges+
                   mutual +transitive+nodematch("democracy")+nodeocov("democracy")+absdiff("cinc")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance")
                 , R=100)

  return(est1, est2, est3, est4)
}














