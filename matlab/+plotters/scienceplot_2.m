classdef scienceplot_2
  properties
    scale = 1; %Latex scale factor at which is meant to be exported
    basefontsize = 12; % Base font size for labels, axis and legends before: 16
    titlefontsize = 18; % Base font size for title before: 24
    linewidth = 1.2; % Base line width for plots
    out_dir = "./"; 
    ratio = 6/8; %default aspect ratio (height/width) in Matlab Figures
    plotlinewidth=1.5;
    add_space = 0;
  end 
    methods 
        function format(obj,titulo, Xlabel, Ylabel, rot, Zlabel)
            arguments
                obj
                titulo (1,1) string = ""
                Xlabel (1,1) string = ""
                Ylabel (1,1) string = ""
                rot (1,1) double = 90 
                Zlabel (1,1) string = missing
            end
            
            % scaling factors for font sizes and line widths
            fontsize_label = obj.basefontsize/obj.scale; 
            fontsize_title = obj.titlefontsize/obj.scale;
            linewidth = obj.linewidth/obj.scale;

            % Labels
            xlabel(Xlabel, 'FontSize', fontsize_label, 'Interpreter', 'latex');
            ylabel(Ylabel, 'FontSize', fontsize_label, 'Interpreter', 'latex','Rotation', rot); 
            
            if ~ismissing(Zlabel)
                zlabel(Zlabel, 'FontSize', fontsize_label, 'Interpreter', 'latex');
            end
            
            % Title
            if titulo~=""
            t = title("\fontsize{" + num2str(fontsize_title) + "}{0}\selectfont " + titulo,'Interpreter', 'latex');
            t.Units = 'normalized';
            t.Position(2) = 1.05; 
            clear t;
            end
            % Axis, ticks and boxes
            set(gca, 'FontSize', fontsize_label,'TickLabelInterpreter','latex'); %font size for ticks labels
            set(gca, 'LineWidth', linewidth); %linewidth for axes and boxes
            set(gca, 'Box', 'on'); % Marco alrededor de la gráfica
            set(gca, 'TickDir','in', 'TickLength', [0.01 0.01]); %length of ticks
            set(gca, 'Color', 'w'); % white background

            % Figure configuration
            fig = gcf;
            fig.Theme = "light"; %light theme. Standard in papers
            fig.Units = 'centimeters'; 
            fig.InnerPosition(3:4) = 19*[1, obj.ratio];
            fig.PaperSize(1:2) = fig.InnerPosition(3:4).*([1,1] + [0,obj.add_space]); % Set paper size to match figure size
           
        end


        function colorbar_format(obj, label, type)
            arguments 
            obj
            label (1,1) string = "" 
            type (1,1) string {mustBeMember(type, {'quantum_optics', 'default'})} = 'quantum_optics'
          end
          fontsize_label = obj.basefontsize/obj.scale; 
          linewidth = obj.linewidth/obj.scale;
          
          ax = gca; 
          axis(ax,'xy')
          axis(ax,'equal')
          axis(ax,'tight')
          if strcmp(type, 'quantum_optics')
              colormap(ax, bluewhitered(256)); % Use bluewhitered colormap for quantum optics
          else
              colormap(ax, jet); % Use jet colormap for default
          end
          c = colorbar;
          c.Label.String = label;
          c.Label.Interpreter = 'latex';
          c.Label.FontSize = fontsize_label;
          c.LineWidth = linewidth;
          c.TickLabelInterpreter = 'latex';
          c.TickDirection = "out";
          c.FontSize = fontsize_label;
        end


        function legend(obj, names)
        arguments 
        obj
        names (1,:) string 
        end
        fontsize_legend = obj.basefontsize/obj.scale;
                legend(names,"Location","best",FontSize=fontsize_legend,Interpreter="latex")
        end

        function broaden(obj, dxizq,dxder,dyinf,dysup)
        arguments 
        obj 
        dxizq (1,1) double
        dxder (1,1) double
        dyinf (1,1) double
        dysup (1,1) double
        end 
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
        function myplot(obj, x, y, colorstyle, linestyle)
       arguments
       obj 
       x (1,:) double 
       y (1,:) double 
       colorstyle (1,1) double = 1
       linestyle (1,1) double = 1
        end
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
             mylinewidth = obj.plotlinewidth + 1 - obj.scale;
            plot(x,y,Color=mycolor,LineStyle=myline, LineWidth=mylinewidth, Marker="none"); 
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

        function export(obj, name, options)
            % Function for exporting graphs in different formats (pdf, eps, png)
            arguments
              obj 
              name (1,1) string
              options.format (1,1) string {mustBeMember(options.format, {'pdf', 'eps', 'png'})} = 'pdf'
              options.res (1,1) double = NaN
            end 
            switch options.format
                case 'pdf'
                    print(fullfile(obj.out_dir, name), '-dpdf');
                    if ~isnan(options.res)
                        % If resolution is specified, use the '-r' option for higher quality
                        print(fullfile(obj.out_dir, name), '-dpdf', ['-r', num2str(options.res)]);
                    end
                case 'eps'
                    print(fullfile(obj.out_dir, name), '-depsc');
                case 'png'
                    print(fullfile(obj.out_dir, name), '-dpng', '-r300'); % 300 dpi para alta calidad
                    if ~isnan(options.res)
                        % If resolution is specified, use the '-r' option for higher quality
                        print(fullfile(obj.out_dir, name), '-dpng', ['-r', num2str(options.res)]);
                    end
                otherwise
                    error('format not soported. Please introduce "pdf", "eps" o "png".');
            end
        end
    end
end
