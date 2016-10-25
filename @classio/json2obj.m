function json2obj(self,fname)
%% json2obj
% 
% wrapper function for jsonlab -> save/load json files. 
%
% does not load dependent properties 
% 
% inputs:
%   fname -> full path/name to file
% 
% author: john devitis
% create date: 24-Oct-2016 15:22:29
   
    % setup
    fprintf('Loading object... ')
    if nargin < 2
        warning('please supply a source file (full file path)');
    end
    
    cn = class(self);           % get class name
    names = fieldnames(self);   % get object field names
    
    % find dependent properties (dep props will throw error on load)
    ci = eval(sprintf('?%s',cn)); % gen and eval cmd -> '?<classname>'
    for ii = 1:length(ci.PropertyList)
        % loop through properties and grab dependent boolean
        loadid(ii) = ci.PropertyList(ii).Dependent; 
    end
    
    % load json to matlab struct
    tmp = loadjson(fname);
    allnames = fieldnames(tmp); 
    
    % un-nest object(s) from root object
    for ii = 1:length(allnames);
        if strcmp(cn,allnames{ii})
            fprintf(' ... found object in file... ');
            jname = allnames{ii};            
        else
            fprintf('Did not find object in file. Aborting.\n');
            return
        end
    end
    
    jnames = fieldnames(tmp.(jname));
    % loop to populate consistent struct names of root object
    fprintf(' ... loading object contents... ');
    for ii = 1:length(names)
        for jj = 1:length(jnames)
            % save ONLY if names match and property not dependent
            if strcmp(names{ii},jnames{jj}) && ~loadid(ii)
                self.(names{ii}) = tmp.(jname).(names{ii});
            end
        end
    end
    
    fprintf('Done.\n');

	
end
