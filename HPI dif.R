# Magdalena Cortina
# RA for Professor Esteban López
# This script plots the difference between different HPI estimations (with and without weight)
# RES is the data with the indices coming from R Script "ResCombine_exp.R"
######################################

# Plots by difference between HPI
# difference 1: HPI (sin expansor)no  - HPI expansor 1
# difference 2: HPI expansor 1 - HPI expansor 2

RES <- RES[,1:8]
RES <- RES %>% 
  pivot_wider(names_from = index, values_from = Value) %>% 
  pivot_longer(starts_with("HPI"), names_to = "index", values_to = "Value") 
RES <- as.data.table(RES)
RES <- RES %>% spread(index,Value) %>% 
  mutate(HPI_dif1=HPI-HPI_1) %>% 
  mutate(HPI_dif2=HPI_1-HPI_2) #%>% 
  #mutate(Med_dif=Median-HPI) %>% 
  #mutate(Med_dif1=Median-HPI_1) %>% 
  #mutate(Med_dif2=Median-HPI_2)

RES[,HPI:=NULL][,HPI_1:=NULL][,HPI_2:=NULL]#[,Median:=NULL]

RES <- RES %>% gather(index, Value, HPI_dif1:HPI_dif2) %>% as.data.table()


# plot by HPI difference
for(i in idcom$m_index){
  ggplot(RES[idcomuna==i,],aes(x=interaction(month,year,sep = " "), group = "1")) +
  #ggplot(RES[idcomuna==i],aes(x=interaction(quarter,year,sep = " "), group = "1")) +  
    geom_line(aes(y = Value)) +
    geom_point(aes(y = Value)) +
    theme(legend.position='bottom',legend.title=element_blank(),axis.text.x = element_text(angle = 90))+ 
    geom_hline(aes(yintercept=0,color="red"),show.legend = F)+ 
    labs(title = "HPI with and without weights ",subtitle = paste("Municipality of",idcom[m_index==i,]$Descripcion),caption = ("dif1 = HPI - HPI 1, dif2 = HPI 1 - HPI 2"),y="Index",x="Month") +
    facet_grid(index~operacion)
  ggsave(filename = paste0(pathR,"01_Comuna/Monthly/01.4_Plots/Dif/",i,"_",idcom$Descripcion[i],".pdf"),width = 11.5, height = 8)
  #ggsave(filename = paste0(pathR,"01_Comuna/Quarterly/01.4_Plots/Dif/",i,"_",idcom$Descripcion[i],".pdf"),width = 11.5, height = 8)
}

## dif1 = HPI - HPI_1
## dif2 = HPI_1 - HPI_2

