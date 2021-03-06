classdef SwarmRobot
    %GENETICROBOT 
    %   The body of robot contain all data.
    %   Autor: Julio Lima
    
   properties
    X;
    w;
    pI = [0 0];
    pG = [0 0];
    c1 = 2.05;
    c2 = 2.05;
    r1;
    r2;
    V;
    f;
    scope;
   end
   methods
    function robot = SwarmRobot(rScope)
       robot.X = [rand() rand()];
       robot.w = rand()*0.4;
       robot.r1 = rand();
       robot.r2 = rand();
       robot.V = [rand() rand()];
       robot.f = getEvaluation(robot);
       robot.pI = robot.X;
       robot.scope = rScope;
    end
    function newRobot = move(robot,bestRobot)
        %Verify if the actual position its the best one.
        robot.pG = bestRobot;
        initial = robot.getPosition();
        robot.X = robot.updatePosition();
        auxF = getEvaluation(robot);
        if((auxF>robot.f))
            if(robot.X(1)>robot.scope || robot.X(1)<0) || (robot.X(2)>robot.scope || robot.X(2)<0)
            else            
                robot.f = auxF;
                robot.pI = getPosition(robot);
            end
        end
        newRobot = robot;
    end
    function [returnX, returnF] = getXF(robot)
        %Get the evaluation and position of robot.
        returnX = robot.X;
        returnF = robot.getEvaluation();
    end
    function evaluation = getEvaluation(robot)
        %Calculate the locus of the robot.
        x = robot.X(1);
        y = robot.X(2);
        evaluation = abs(x*sin((y*pi())/4) + y*sin((x*pi())/4));
    end
    function position = getPosition(robot)
        %Get position of robot.
        position = robot.X;
    end
    function position = updatePosition(robot)
        %Calculate position of robot.
        position = robot.X + getVelocity(robot);
    end
    function velocity = getVelocity(robot)
        %Calculate velocity of robot.
        robot.V = (rand()*0.4).*robot.V + (robot.c1).*rand().*minus(robot.pI,robot.X) +(robot.c2).*rand().*minus(robot.pG,robot.X);
        velocity = robot.V;
    end
   end
end