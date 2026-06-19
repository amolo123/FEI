import docx2txt

def read_docx_file(file_path):
    my_text = docx2txt.process(file_path)
    return my_text