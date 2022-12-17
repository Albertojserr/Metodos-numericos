clear
clf
x0=-0.2+rand(20,1)*0.4;%esto hay que subirlo
Px0=-0.2+rand(20,1)*0.4;
a=6;%Este se cambia al máximo que queramos imprimir
while a>=6 %Este se cambia al mínimo que queramos imprimir
    clf
    h=1/a;
    for i=1:length(x0)
        HenonHelles(x0(i),Px0(i),h)

    end
    txt=['H: 1/' num2str(a) ''];
    text(0.5,0.5,txt,'FontSize',12)
    xlabel('X')
    ylabel('Y')

    str = "EspacioConfig" + a + ".png";
    saveas(gcf,str)
    a=a-1;
end
function[]=HenonHelles(x0,px0,h)
    At=0.001;
    t=[0:At:50];
    y0=0.0;
    h=h;%hay que ir cambiando esta 1/6<h
    py0=sqrt(2*(h-x0^2*y0+(y0^3)/3)-(px0^2+x0^2+y0^2));
    d=length(t);
    xe2(1)=x0; %Condición inicial
    pxe2(1)=px0; %Condición inicial
    ye2(1)=y0; %Condición inicial
    pye2(1)=py0;
    te(1)=0;
    for i=1:1:3
        xe2(i+1)=xe2(i)+At*xe2(i);
        pxe2(i+1)=pxe2(i)+At*pxe2(i);
        ye2(i+1)=ye2(i)+At*ye2(i);
        pye2(i+1)=pye2(i)+At*pye2(i);
    end
    lambda=1;
    for i=4:1:d-1
        Afx=xe2(i-3:i);
        Afpx=pxe2(i-3:i);
        Afy=ye2(i-3:i);
        Afpy=pye2(i-3:i);

        k1=Afpx;
        kp1=-Afx-2*lambda.*Afx.*Afy;
        ky1=Afpy;
        kpy1=-Afy-lambda*(Afx.^2-Afy.^2);

        xe2(i+1)=xe2(i)+(At/24)*(55*k1(4)-59*k1(3)+37*k1(2)-9*k1(1));
        pxe2(i+1)=pxe2(i)+(At/24)*(55*kp1(4)-59*kp1(3)+37*kp1(2)-9*kp1(1));
        ye2(i+1)=ye2(i)+(At/24)*(55*ky1(4)-59*ky1(3)+37*ky1(2)-9*ky1(1));
        pye2(i+1)=pye2(i)+(At/24)*(55*kpy1(4)-59*kpy1(3)+37*kpy1(2)-9*kpy1(1));

    end
    hold on
    plot(xe2, ye2, 'r.', 'Markersize', 4)
    

    %A continuación escribo comentado las cosas que habría que cambiar para
    %ver el espacio de configuraciones. Nos saldrá algo como un dorito. Si
    %nos sale una parte llena de puntos como formando una columna entonces
    %es una estructura hiperbólica. Sino puede salir una caótica.

    %plot(xe2, ye2, 'r.', 'Markersize', 4)
    %t=[0:At:50];
    %x0=-0.2+rand(20,1)*0.4;%esto hay que subirlo
    %Px0=-0.2+rand(20,1)*0.4;

end