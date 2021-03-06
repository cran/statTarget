#' @title StatTarget interface
#' @description Get the statTarget GUI session. The Shift Correction and Statistical Analysis session being used by statTarget. Will restart statTarget if it died for some reason. Features of the package statTarget includes shift correction, typical quality control based robust LOESS signal correction (such as QC.RLSC); Data preprocessing, data descriptions, PCA, PLSDA, OPLSDA, VIP, ROC, random forest, odd ratio, Student T-test, Shapiro-Wilk normality test and Mann-Whitney tests; Data preprocessing includes 80-precent rule, log transformation, normalization. Data descriptions includes mean value, median value, sum, quartile, standard derivatives, etc.
#' @author Hemi Luan hemi.luan@gmail.com
#' @references Dunn WB., et al. Nat Protoc. 2011, 6, pp1060.
#' @references Luan H., et al. GigaScience 2015, 4, pp16.
#' @references Luan H., et al. J. Proteome Res., 2015, 14, pp467.
#' @keywords GUI
#' @keywords statTarget
#' @keywords metabolomics
#' @keywords QCRLSC for shift correction
#' @keywords statistical analysis
#' @export
`statTarget.gui` <- function() {
  #require(gWidgets2)
  #require(gWidgetsRGtk2)
  #.statTarget <- new.env()
  color<-grDevices::colors()
  #cl<-color[c(552,26,254,32,47,68,73,81,84,100,142,362,372,536,541,547,455,445)]#,0:20*5+152,133)]
  linetype<-c("solid","dashed","dotted","dotdash","longdash","twodash","F8","431313","22848222")
  linetype<-rep(linetype,4)
  #assign("traitlth",NA, envir=.qtlnetworkr)
  #assign("traitname",NA, envir=.qtlnetworkr)
  #assign("chromosome",NA, envir=.qtlnetworkr)
  widgets<-list()
  win = gWidgets2::gwindow("Wellcome to statTarget")#, width=700, height=400)
  #gf <- gframe("frame", horizontal=FALSE, container=win)
  #font(win) <- list(weight="light", color = "red")
  gp = gWidgets2::ggroup(horizontal=FALSE, container=win, expand=TRUE)  # main group
  #imagepath = paste(system.file("extdata",package="statTarget"),sep = "")
  gi = gWidgets2::gimage("shinv.png",system.file("extdata",package="statTarget"),cont=gp)
   #font(gl) <- list()
  #gWidgets2::font(b2) <- list(color = "brown4")
  #gWidgets2::font(gl) <- list(color = "brown4")
  
  #gl = gtext(gl, container=gp, font.attr=list(background="red"))
  #gf = gframe(horizontal=FALSE, cont=win, expand=TRUE) 
  #svalue(gp) <- 0
  
  tmp <- gWidgets2::gframe("Files", container=gp, expand=TRUE)
  lyout<-gWidgets2::glayout(container=tmp)
  #font(lyout) <- list(background = "grey90")
  lyout[1,1]<-gWidgets2::gbutton("Pheno File...", cont=lyout,
                         handler = function(h,...) {
                        std<-gWidgets2::gfile(text="Select Pheno File...",filter=list("Pheno files" = list(patterns = c("*.csv")),"All files"=list(patterns=c("*"))))
                        if(std != "")
                        {
                          if(length(grep("\\",std,fixed=TRUE))>0){
                            mystr<-strsplit(std,split="\\",fixed=T)[[1]]
                            mystr.lth<-mystr[length(mystr)]
                            mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
                            setwd(mydir)
                          }else if(length(grep("/",std,fixed=TRUE))>0){
                            mystr<-strsplit(std,split="/",fixed=T)[[1]]
                            mystr.lth<-mystr[length(mystr)]
                            mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
                            setwd(mydir)
                          }
                          samP <- std
                          #y <- 1:as.numeric(x[grep("_c|Chromosome",x[,1]),2])
                          #assign("pfile",samP, envir=.statTarget)
                          #assign("chromosome",y, envir=.qtlnetworkr)
                          gWidgets2::svalue(widgets$pheno) <- samP
                        }
                      })
  lyout[1,2]<-(widgets$pheno<-gWidgets2::gedit(text="",cont=lyout))
  lyout[2,1]<- gWidgets2::gbutton("Profile File...", cont = lyout, handler = function(h,...) {
    std <- gWidgets2::gfile("Select Profile File...",filter=list("Profile files" = list(patterns = c("*.csv")),"All files"=list(patterns=c("*"))))
    if(std != "") {
      if(length(grep("\\",std,fixed=TRUE))>0){
        mystr<-strsplit(std,split="\\",fixed=T)[[1]]
        mystr.lth<-mystr[length(mystr)]
        mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
        setwd(mydir)
      }else if(length(grep("/",std,fixed=TRUE))>0){
        mystr<-strsplit(std,split="/",fixed=T)[[1]]
        mystr.lth<-mystr[length(mystr)]
        mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
        setwd(mydir)
      }
      samF <- std
      #y <- length(grep("_trait",x[,1]))
      #z <- x[grep("^_trait$",x[,1]),3]
      #assign("sfile",samF, envir=.statTarget)
      #assign("traitlth",y, envir=.qtlnetworkr)
      #assign("traitname",z, envir=.qtlnetworkr)
      gWidgets2::svalue(widgets$profile) <- samF
    }
  })
  lyout[2,2]<-(widgets$profile<-gWidgets2::gedit(text="",cont=lyout))
  
  lyout[3,1]<- gWidgets2::gbutton("Stat File...", cont = lyout, handler = function(h,...) {
    std <- gWidgets2::gfile("Select Stat File...",filter=list("Stat files" = list(patterns = c("*.csv")),"All files"=list(patterns=c("*"))))
    if(std != "") {
      if(length(grep("\\",std,fixed=TRUE))>0){
        mystr<-strsplit(std,split="\\",fixed=T)[[1]]
        mystr.lth<-mystr[length(mystr)]
        mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
        setwd(mydir)
      }else if(length(grep("/",std,fixed=TRUE))>0){
        mystr<-strsplit(std,split="/",fixed=T)[[1]]
        mystr.lth<-mystr[length(mystr)]
        mydir<-substr(std,1,stop=(nchar(std)-nchar(mystr.lth)-1))
        setwd(mydir)
      }
      stat <- std
      #y <- length(grep("_trait",x[,1]))
      #z <- x[grep("^_trait$",x[,1]),3]
      #assign("statfile",stat, envir=.statTarget)
      #assign("traitlth",y, envir=.qtlnetworkr)
      #assign("traitname",z, envir=.qtlnetworkr)
      gWidgets2::svalue(widgets$stat)<-stat
    }
  })
  lyout[3,2]<-(widgets$stat<-gWidgets2::gedit(text="",cont=lyout))
  
  #tb = list()
  #tb$save <- list(icon="save",handler = function(...) print("save"))
  #tb$New <- list(icon="StatTarget Analysis Start ...",handler = function(...) print("StatTarget Analysis Start ..."))
  #tb = gtoolbar(tb, cont=gp)
  
  ##prepare for data file ready
  gl <- gWidgets2::glabel("\n StatTarget Analysis\n", container=gp)
  gWidgets2::font(gl) <- list(weight="normal",color= "navyblue")
  
  nb = gWidgets2::gnotebook(cont = gp)
  #font(nb) <- list(size= 6, background = "grey90")
  shiftco_win = gWidgets2::ggroup(horizontal=FALSE, cont=nb, label="Shift Correction")
  stat_win =gWidgets2::ggroup(horizontal=FALSE, cont=nb, label="Statistical Analysis")
  sb <- gWidgets2::gstatusbar("Status...", container=win)
  gWidgets2::font(sb) <- list(size= 9,color= "red")
  lyout<-gWidgets2::glayout(container=shiftco_win)
  #font(lyout) <- list(background = "grey90")
  lyout[1,1]<-gWidgets2::gbutton("MissingValueFilter",cont=lyout)
  lyout[1,2]<-(widgets$Frule<-gWidgets2::gedit("0.8",cont=lyout))
  lyout[2,1]<-gWidgets2::gbutton("QC span",cont=lyout)
  lyout[2,2]<-(widgets$QCspan<-gWidgets2::gedit("0",cont=lyout))
  lyout[3,1]<-gWidgets2::gbutton("Degree",cont=lyout)
  lyout[3,2]<-(widgets$degree<-gWidgets2::gcombobox(c("2","1","0"),cont=lyout))
  lyout[4,1]<-gWidgets2::gbutton("Imputation Method",cont=lyout)
  lyout[4,2]<-(widgets$imputeM<-gWidgets2::gcombobox(c("KNN","min","median"),cont=lyout))
  button.group <- gWidgets2::ggroup(container = shiftco_win)
  ## Push buttons to right
  gWidgets2::addSpring(button.group)
  gsc <- gWidgets2::gbutton("Run",handler=function(h,...){
    #close.cur.dev()
    samPeno = gWidgets2::svalue(widgets$pheno)
    samFile = gWidgets2::svalue(widgets$profile)
    Frule = gWidgets2::svalue(widgets$Frule)
    Frule = as.numeric(Frule)
    QCspan = gWidgets2::svalue(widgets$QCspan)
    QCspan = as.numeric(QCspan) 
    degree = gWidgets2::svalue(widgets$degree)
    degree = as.numeric(degree) 
    imputeM = gWidgets2::svalue(widgets$imputeM)
    shiftCor(samPeno,samFile,Frule = Frule, QCspan = QCspan, degree = degree,imputeM = imputeM)
    gWidgets2::svalue(sb) <- "Shift Correction Finished!"}, 
    container=button.group)
  
  lyout<-gWidgets2::glayout(container=stat_win)
  lyout[1,1]<-gWidgets2::gbutton("MissingValueFilter",cont=lyout)
  lyout[1,2]<-(widgets$Frule<-gWidgets2::gedit("0.8",cont=lyout))
  lyout[2,1]<-gWidgets2::gbutton("Imputation Method",cont=lyout)
  lyout[2,2]<-(widgets$imputeM<-gWidgets2::gcombobox(c("KNN","min","median"),cont=lyout))
  lyout[3,1]<-gWidgets2::gbutton("Glog transformation",cont=lyout)
  lyout[3,2]<-(widgets$Glog<-gWidgets2::gcombobox(c("TRUE","FALSE"),cont=lyout))
  lyout[4,1]<-gWidgets2::gbutton("Scaling method",cont=lyout)
  lyout[4,2]<-(widgets$scalingMethod<-gWidgets2::gcombobox(c("Pareto","Auto","Vast","Range"),cont=lyout))
  lyout[5,1]<-gWidgets2::gbutton("Multi.Test",cont=lyout)
  lyout[5,2]<-(widgets$multiTest<-gWidgets2::gcombobox(c("TRUE","FALSE"),cont=lyout))
  lyout[6,1]<-gWidgets2::gbutton("Permutation times",cont=lyout)
  lyout[6,2]<-(widgets$Permutation<-gWidgets2::gedit("500",cont=lyout))
  lyout[7,1]<-gWidgets2::gbutton("PCs in Xaxis ",cont=lyout)
  lyout[7,2]<-(widgets$pcaX<-gWidgets2::gedit("1",cont=lyout))
  lyout[8,1]<-gWidgets2::gbutton("PCs in Yaxis ",cont=lyout)
  lyout[8,2]<-(widgets$pcaY<-gWidgets2::gedit("2",cont=lyout))
  lyout[9,1]<-gWidgets2::gbutton("nvarRF",cont=lyout)
  lyout[9,2]<-(widgets$nvarRF<-gWidgets2::gedit("20",cont=lyout))
  button.group <- gWidgets2::ggroup(container = stat_win)
  ## Push buttons to right
  gWidgets2::addSpring(button.group)
  gWidgets2::gbutton("Run", handler=function(h,...){
    #close.cur.dev()
    file = gWidgets2::svalue(widgets$stat)
    Frule = gWidgets2::svalue(widgets$Frule)
    Frule = as.numeric(Frule)
    imputeM = gWidgets2::svalue(widgets$imputeM)
    glog = gWidgets2::svalue(widgets$Glog)
    test.multi = gWidgets2::svalue(widgets$multiTest)
    nvarRF = gWidgets2::svalue(widgets$nvarRF)
    nvarRF = as.numeric(nvarRF)
    scaling = gWidgets2::svalue(widgets$scalingMethod)
    silt = gWidgets2::svalue(widgets$Permutation)
    silt = as.numeric(silt)
    pcax = gWidgets2::svalue(widgets$pcaX)
    pcax = as.numeric(pcax)
    pcay = gWidgets2::svalue(widgets$pcaY)
    pcay = as.numeric(pcay)
    statAnalysis(file=file, Frule = Frule,imputeM = imputeM,glog=glog, test.multi=test.multi, nvarRF =nvarRF, scaling =scaling,silt = silt, pcax = pcax, pcay = pcay)
    #file, Frule = 0.8,imputeM = "KNN", glog = TRUE, test.multi=TRUE, nvarRF =10, scaling = "Pareto",silt = 500, pcax = 1, pcay = 2
    #for(i in 1:100) {Sys.sleep(.1); svalue(pbar) <- i}
    },container=button.group)
   Quit <- gWidgets2::gbutton("Quit",container=gp,handler = function(h,...) {gWidgets2::dispose(win)})
}

