#' A Function to run TERGM for the post-Cold War years
#'
#' @param data.frame Final dataset used in the project
#' @return data.frame with independent variables for 2000-2012 years, data.frame with netinf estimates
#' @export
#'
tergm_2000 <-function(ivs00, edgelist){
  set.seed(11235)
  edgelist <- subset(edgelist, year>=2000&year<2013)
  # cname that exist in edgelist but not in ivs?
  edgelist_system <- subset(edgelist,(edgelist$state_01 %in% ivs00$cname)&(edgelist$state_02 %in% ivs00$cname))

  #unique(edgelist$state_01)


  net00 <- list()


  for (yr in 1:13) {
    # Subset by year
    dataYr <- subset(ivs00, year==(yr+1999))

    #no nulls
    #dataYr[is.na(dataYr)] <-
    elYr <- subset(edgelist_system, year==(yr+1999))
    elYr$year <- NULL
    elYr$lambda <- NULL


    nv <- nrow(dataYr)

    net00[[yr]] <- network.initialize(nv)

    network.vertex.names(x=net00[[yr]]) <- dataYr$cname

    net00[[yr]][as.matrix(elYr)] <- 1

    #Apply nodal attributes
    set.vertex.attribute(x=net00[[yr]],attrname="major",value=dataYr$major)
    set.vertex.attribute(x=net00[[yr]],attrname="democracy",val=dataYr$democ)
    set.vertex.attribute(x=net00[[yr]],attrname="cinc",value=dataYr$cinc)
    set.vertex.attribute(x=net00[[yr]],attrname="totalpop",value=dataYr$tpop)
    set.vertex.attribute(x=net00[[yr]],attrname="urbanpop",value=dataYr$upop)
    set.vertex.attribute(x=net00[[yr]],attrname="region",value=dataYr$region)

    #Apply edge attributes

    set.network.attribute(x=net00[[yr]], attrname="distance", value=as.matrix(distance00))
    set.network.attribute(x=net00[[yr]], attrname="trade", value=as.matrix(tradelist00[[yr]]))

  }

  ## btergm models

  est1_2 <- btergm(net00~ edges+
                     mutual +transitive+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance"),
                   R=100)

  ##
  est2_2 <- btergm(net00~ edges+
                     mutual +nodematch("democracy")+nodeocov("democracy")+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance"),
                   R=100)


  ##
  est3_2 <- btergm(net00~ edges+
                     mutual +transitive+nodematch("democracy")+nodeocov("democracy")+nodeocov("major")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance"),
                   R=100)

  ##
  est4_2 <- btergm(net00~ edges+
                     mutual +transitive+nodematch("democracy")+nodeocov("democracy")+absdiff("cinc")+ nodeocov("totalpop")+nodeocov("urbanpop")+nodematch("region")+edgecov("trade")+edgecov("distance"),
                   R=100)


  return(est1_2, est2_2, est3_2, est4_2)
}
