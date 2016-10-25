function obj2json(self,pth,name)
%% save2json
% 
% wrapper function for jsonlab -> save/load json files
%
% inputs: 
%   pth -> path to file
%   name -> file name (.json assumed)
% 
% * defaults to use classname as filename - override with optional 'name' 
% input
% * also defaults to using the root object as the class name
%
% author: john devitis
% create date: 24-Oct-2016 15:06:31
    ext = '.json';
    
    % check path
	if nargin < 2
        warning('please supply a destination for file');
    end
    
    % check filename
    if nargin < 3
        name = class(self); % get class name
    end
    
    % format json string
    str = savejson(name,self);
    
    % save to file - CAUTION - this will overwrite filename
    fprintf('Saving %s class... ',name);
    fid = fopen(fullfile(pth,[name ext]),'w');
	fwrite(fid,str);
    fclose(fid);	
    fprintf('Done.\n');
	
end
