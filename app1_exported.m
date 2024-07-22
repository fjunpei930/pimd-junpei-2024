classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        compute2Button  matlab.ui.control.Button
        computeButton   matlab.ui.control.Button
        loadButton      matlab.ui.control.Button
        UIAxes3         matlab.ui.control.UIAxes
        UIAxes2         matlab.ui.control.UIAxes
        UIAxes          matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: loadButton
        function loadButtonPushed(app, event)
            filename = uigetfile('*.png');
            im = imread(filename);
            imshow(im, 'Parent', app.UIAxes);
        end

        % Button pushed function: computeButton
        function computeButtonPushed(app, event)
            filename = uigetfile('*.png');
            im = imread(filename);
            imgray = rgb2gray(im);
            BW = imbinarize(imgray);
            imshow(BW*255, 'Parent', app.UIAxes2);
        end

        % Button pushed function: compute2Button
        function compute2ButtonPushed(app, event)
            filename = uigetfile('*.png');
            im = imread(filename);
            imgray = rgb2gray(im);
            canny = edge(imgray,'canny');
            imshow(canny, 'Parent', app.UIAxes3);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 619];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [24 410 300 185];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Title')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [25 216 300 185];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Title')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.Position = [26 21 300 185];

            % Create loadButton
            app.loadButton = uibutton(app.UIFigure, 'push');
            app.loadButton.ButtonPushedFcn = createCallbackFcn(app, @loadButtonPushed, true);
            app.loadButton.Position = [378 443 100 23];
            app.loadButton.Text = 'load';

            % Create computeButton
            app.computeButton = uibutton(app.UIFigure, 'push');
            app.computeButton.ButtonPushedFcn = createCallbackFcn(app, @computeButtonPushed, true);
            app.computeButton.Position = [378 307 100 23];
            app.computeButton.Text = 'compute';

            % Create compute2Button
            app.compute2Button = uibutton(app.UIFigure, 'push');
            app.compute2Button.ButtonPushedFcn = createCallbackFcn(app, @compute2ButtonPushed, true);
            app.compute2Button.Position = [379 113 100 23];
            app.compute2Button.Text = 'compute2';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end