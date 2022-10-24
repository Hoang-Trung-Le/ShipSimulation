classdef PlaceObj < handle
    properties
        ply;
        objPose;
        objMesh_h;
        objVerts;
        objVertexCount;
    end
    methods
        function self = PlaceObj(ply)
            self.ply = ply;
            [f,v,data] = plyread(ply,'tri');
            % Get vertex count
            self.objVertexCount = size(v,1);
            % Move center point to origin
            midPoint = sum(v)/self.objVertexCount;
            self.objVerts = v - repmat(midPoint,self.objVertexCount,1);
            % Create a transform to describe the location (at the origin, since it's centered
            self.objPose = eye(4);
            % Scale the colours to be 0-to-1 (they are originally 0-to-255
            try
                try
                    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
                catch
                    try
                        vertexColours = [data.face.red, data.face.green, data.face.blue] / 255;
                    catch
                        vertexColours = [0.5,0.5,0.5];
                    end
                end
%                 mesh_h = zeros(size(locations,1),1);
                % Then plot the trisurf
%                 for i = 1: size(locations,1)
                    self.objMesh_h = trisurf(f,self.objVerts(:,1),self.objVerts(:,2), self.objVerts(:,3) ...
                        ,'FaceVertexCData',vertexColours,'EdgeColor','none','EdgeLighting','none');
%                 end
            catch ME_1
                disp(ME_1);
            end
        end
        
        function MoveObj(self, pose)
            self.objPose = eye(4);
            % Move forwards (facing in -y direction)
            forwardTR = makehgtform('translate',pose(1:3));
            % Random rotate about Z
            zRotateTR = makehgtform('zrotate',pose(6));
            yRotateTR = makehgtform('yrotate',pose(5));
            xRotateTR = makehgtform('xrotate',pose(4));
            % Move the pose forward and a slight and random rotation
            self.objPose = self.objPose * forwardTR * xRotateTR * yRotateTR * zRotateTR;
            updatedPoints = [self.objPose * [self.objVerts, ones(self.objVertexCount,1)]']';
            % Now update the Vertices
            self.objMesh_h.Vertices = updatedPoints(:,1:3);
            
        end
    end
end
