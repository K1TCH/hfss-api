function hfssAssignFiniteCond(fid, Name, Material, varargin)
	% Creates the VB Script necessary to assign a finite conductivity to an 
	% existing two-dimensional HFSS object
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% Name:			name of the object to which the material is to assigned.
	% Material:		the material to be assigned to the Sheet. This is a string that should either be predefined in HFSS or defined using hfssAddMaterial(...)
    % varargin:     (Optional): specify the name of the assigned finite conductor (defaults to 'FiniteCond1' if nothing specified)
	% 
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssAssignFiniteCond(fid, 'PatchArray2D', 'copper', 'PatchArrayFiniteCond'); 
	% @endcode
	%
    
    if nargin < 4
        condName = 'FiniteCond1';
    else
        condName = varargin{1};
    end

	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');
    fprintf(fid, 'oModule.AssignFiniteCond _\n');
	fprintf(fid, '\tArray("NAME:%s", _\n', condName);
	fprintf(fid, '\t\t"Objects:=", Array("%s"), _\n', Name);  
    fprintf(fid, '\t\t"UseMaterial:=", true, _\n');
    fprintf(fid, '\t\t"Material:=", "%s", _\n', Material);
    fprintf(fid, '\t\t"UseThickness:=", false, _\n');
    fprintf(fid, '\t\t"Roughness:=", "0um", _\n');
    fprintf(fid, '\t\t"InfGroundPlane:=", false, _\n');
    fprintf(fid, '\t\t"IsTwoSided:=", false, _\n');
    fprintf(fid, '\t\t"IsInternal:=", true)\n');
    