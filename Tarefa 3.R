install.packages("rvest")
library(rvest)
library(dplyr)

link="https://www.imdb.com/search/title/?genres=sci_fi&sort=user_rating,desc&title_type=feature&num_votes=25000,&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=5aab685f-35eb-40f3-95f7-c53f09d542c3&pf_rd_r=RT6N7198WSADC9HMHFPJ&pf_rd_s=right-6&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_gnr_17"
page = read_html(link)

name=page%>%
  html_nodes(".lister-item-header a")%>%
  html_text()

year=page%>%
  html_nodes(".text-muted.unbold")%>%
  html_text()

rating=page%>%
  html_nodes(".ratings-imdb-rating strong")%>%
  html_text()

time=page%>%
  html_nodes(".runtime")%>%
  html_text()

diretor=page%>%
  html_nodes(".text-muted+ p a:nth-child(1)")%>%
  html_text()
  

movies1=data.frame(name, year,rating,time,diretor, stringsAsFactors = FALSE)

director<-movies1%>%
  count(diretor)%>%
  arrange(desc(n))%>%
  head(7)

anos<-movies1%>%
  count(year)%>%
  arrange(desc(n))%>%
  head(10)

library(ggplot2)

ggplot(director,aes(x="",y=n,fill=diretor))+
  geom_bar(stat="identity",width=1,color="white")+
  coord_polar("y",start=0)+
  theme_void()+
  geom_text(aes(y = n/2 + c(0, cumsum(n)[-length(n)]), 
                label = n), size=4, color="white")+
  ggtitle("Diretores com mais Filmes no Top 50")+
  guides(fill=guide_legend(title="Diretores"))

install.packages("ggthemes")
library(ggthemes)

ggplot(anos,aes(year,n))+
  geom_bar(stat="identity",fill="white",color="blue")+
  theme_economist()+
  scale_color_economist()+
  ggtitle("Anos com mais filmes no Top 50 de Ficção Científica do IMDB")+
  xlab("Anos")+
  ylab("Quantidade")
