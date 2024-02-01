

function remove_developer_sections_from_html(file, is_developer_doc)
    html_content = read(file, String)

    if !is_developer_doc
        # Define the start and end markers with HTML entity encoding
        start_marker = "<!--- dev:start --->"
        end_marker = "<!--- dev:end --->"

        # Continuously remove sections between start and end markers
        while occursin(start_marker, html_content) && occursin(end_marker, html_content)
            start_range = findfirst(start_marker, html_content)
            end_range = findfirst(end_marker, html_content)

            if start_range === nothing || end_range === nothing
                break
            end

            # Calculate the indices for string slicing
            start_index = first(start_range)
            end_index = last(end_range)
            
            html_content = html_content[begin:start_index-1] * html_content[end_index+1:end]
        end
    end

    # Write the modified HTML back to the file
    write(file, html_content)
end


is_developer_doc = false # or false, based on your target audience

html_files = ["build/collection.html", "build/layers.html"] # List your HTML files

for file in html_files
    remove_developer_sections_from_html(file, is_developer_doc)
end