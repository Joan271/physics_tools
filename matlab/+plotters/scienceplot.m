classdef scienceplot
    methods (Static)
        function formato(titulo, etiquetaX, etiquetaY, rot)
            % Si no se especifican etiquetas, se usan valores por defecto
            if nargin < 1, titulo = 'Título de la gráfica'; end
            if nargin < 2, etiquetaX = 'Eje X'; end
            if nargin < 3, etiquetaY = 'Eje Y'; end
            if nargin < 4, rot = 90; end

            % Aplicar formato con LaTeX
            xlabel(etiquetaX, 'FontSize', 16, 'Interpreter', 'latex');
            ylabel(etiquetaY, 'FontSize', 16, 'Interpreter', 'latex','Rotation', rot);
            t = title("\fontsize{24}{0}\selectfont " + titulo,'Interpreter', 'latex');
            t.Units = 'normalized';
            t.Position(2) = 1.05; 
            clear t;
            % Configuración del estilo científico
            set(gca, 'FontSize', 16,'TickLabelInterpreter','latex'); % Helvetica para compatibilidad con LaTeX
            set(gca, 'LineWidth', 1.2);
            set(gca, 'Box', 'on'); % Marco alrededor de la gráfica
            set(gca, 'TickDir','in', 'TickLength', [0.01 0.01]);
            set(gca, 'Color', 'w'); % Fondo blanco
        end
        function formato3D(titulo, etiquetaX, etiquetaY, etiquetaZ)
            % Si no se especifican etiquetas, se usan valores por defecto
            if nargin < 1, titulo = 'Título de la gráfica'; end
            if nargin < 2, etiquetaX = 'Eje X'; end
            if nargin < 3, etiquetaY = 'Eje Y'; end

            % Aplicar formato con LaTeX
            xlabel(etiquetaX, 'FontSize', 16, 'Interpreter', 'latex');
            ylabel(etiquetaY, 'FontSize', 16, 'Interpreter', 'latex');
            zlabel(etiquetaZ, 'FontSize', 16, 'Interpreter', 'latex');
            t = title("\fontsize{20}{0}\selectfont " + titulo,'Interpreter', 'latex');
            t.Units = 'normalized';
            t.Position(2) = 1.05; 
            clear t;
            % Configuración del estilo científico
            set(gca, 'FontSize', 16,'TickLabelInterpreter','latex'); % Helvetica para compatibilidad con LaTeX
            set(gca, 'LineWidth', 1.2);
            set(gca, 'Box', 'on'); % Marco alrededor de la gráfica
            %set(gca, 'TickDir','in', 'TickLength', [0.01 0.01 0.01]);
            set(gca, 'Color', 'w'); % Fondo blanco
        end

        function leyenda(nombres)
                legend(nombres,"Location","best",FontSize=16,Interpreter="latex")
        end
        function ensanchar(dxizq,dxder,dyinf,dysup)  
            DeltaX = gca().XLim(2) - gca().XLim(1);
            DeltaY = gca().YLim(2) - gca().YLim(1);
            myxlim(1) = gca().XLim(1) - DeltaX*dxizq;
            myxlim(2) = gca().XLim(2) + DeltaX*dxder;
            myylim(1) = gca().YLim(1) - DeltaY*dyinf;
            myylim(2) = gca().YLim(2) + DeltaY*dysup;
            xlim(myxlim);
            ylim(myylim);
        end
        
        function timesticks(nx,ny)
            ax = gca().XTick; 
            bx = linspace(ax(1),ax(end),numel(ax)*nx);
            gca.XTick= bx;

            ay = gca().YTick; 
            by = linspace(ay(1),ay(n),numel(ay),ny); 
            gca.YTick = by; 

        end

        function myerroryplot( x, y, dy,style)
            switch style
                case 1
                    mycolor = [0 0 0]; %negro
                case 2
                    mycolor = [0 0 0.7]; %azul

                case 3
                    mycolor = [0.7 0 0]; %rojo
                case 4
                    mycolor = [0 0.7 0]; %verde
                case 5 
                    mycolor = [0.5 0 0.5]; %púrpura
            end     
            errorbar(x,y,dy,dy, ...
            "Marker","o",'LineStyle','none','MarkerSize',6,MarkerFaceColor='none', MarkerEdgeColor= mycolor,Color=mycolor);
        end
        function myerrorxplot( x, y, dx,style)
            switch style
                case 1
                    mycolor = [0 0 0]; %negro
                case 2
                    mycolor = [0 0 0.7]; %azul

                case 3
                    mycolor = [0.7 0 0]; %rojo
                case 4
                    mycolor = [0 0.7 0]; %verde
                case 5 
                    mycolor = [0.5 0 0.5]; %púrpura
            end     
            errorbar(x,y,dx,'horizontal', ...
            "Marker","o",'LineStyle','none','MarkerSize',6,MarkerFaceColor='none', MarkerEdgeColor= mycolor,Color=mycolor);
        end
        function myplot(x, y, colorstyle, linestyle)
             switch colorstyle
                case 1
                    mycolor = [0 0 0]; %negro
                case 2
                    mycolor = [0 0 0.7]; %azul

                case 3
                    mycolor = [0.7 0 0]; %rojo
                case 4
                    mycolor = [0 0.7 0]; %verde
                case 5 
                    mycolor = [0.5 0 0.5]; %púrpura
            end     
             switch linestyle
                 case 1
                     myline = '-'; 
                 case 2
                     myline = '--'; 
                 case 3
                     myline = '-.';
             end
            plot(x,y,Color=mycolor,LineStyle=myline, LineWidth= 0.7,Marker="none"); 
          end
          function setlogscale(boolx, booly)
            if boolx
                set(gca,'XScale','log');
            end
            if booly
                set(gca,'YScale','log');
            end
        end
          function [alpha1,alpha2,alpha1e,alpha2e]=ajustechifit(datax,datay,sigma,colorstyle,linestyle,boolplot) 
            [alpha1, alpha2, alpha1e,alpha2e] = chifit(datax,datay,sigma);
            if boolplot
            x = [min(datax), max(datax)]; 
            y = alpha1*x + alpha2;
            hold on 
                scienceplot.myplot(x,y,colorstyle,linestyle);
            end 
        end

        function exportar(nombreArchivo, formato)
            % Función para exportar la gráfica en distintos formatos
            if nargin < 2
                formato = 'pdf'; % Por defecto, PDF
            end
            
            switch formato
                case 'pdf'
                    print(nombreArchivo, '-dpdf');
                case 'eps'
                    print(nombreArchivo, '-depsc');
                case 'png'
                    print(nombreArchivo, '-dpng', '-r300'); % 300 dpi para alta calidad
                otherwise
                    error('Formato no soportado. Usa "pdf", "eps" o "png".');
            end
        end
    end
end
