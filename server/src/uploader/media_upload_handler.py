import uuid

import magic
from PIL import Image
from werkzeug.datastructures import FileStorage

from models.file import File
from uploader.upload_handler_utils import store_tmp_file, post_upload, check_filesize_limit, get_max_image_size

allowed_image_mime_types = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/bmp'
]

image_sizes = {
    'xl': 2000,
    'l': 1000,
    'm': 500,
    's': 100,
    'xs': 20,
}


def handle_file_upload(file: FileStorage) -> File:
    """
    Processes an uploaded media file.
    :param args: Request arguments.
    :return: Created media model.
    """
    # Save file in tmp folder
    id = uuid.uuid4().hex
    temp_folder, temp_path, file = store_tmp_file(file, id)

    # Check file size
    check_filesize_limit(file, get_max_image_size(), temp_folder)

    # Get mime type
    mime_type = magic.Magic(mime=True).from_file(temp_path)

    # Call the handler for the appropriate file type
    file_object = None
    if mime_type in allowed_image_mime_types:
        file_object = handle_image_upload(temp_path, file, id)
    else:
        file_object = handle_arbitrary_file_upload(file, id)

    # Clean up
    post_upload(file, temp_folder)
    return file_object


def handle_image_upload(path: str, file, qquuid):
    """
    Processes an uploaded image.
    :param path: Current path of the image.
    :param file: Uploaded file object.
    :param qquuid: Identifier for the image, generated by the uploader.
    :return: Media object representing the image.
    """
    img = Image.open(path)
    extension = img.format.lower()
    img.save('uploads/{}.{}'.format(qquuid, extension))
    file_object = File()
    file_object.filename = '{}.{}'.format(qquuid, extension)
    file_object.original_filename = file.filename
    file_object.height = img.height
    file_object.width = img.width
    file_object.thumbnail_xs = False
    file_object.thumbnail_s = False
    file_object.thumbnail_m = False
    file_object.thumbnail_l = False
    file_object.thumbnail_xl = False

    # Create thumbnails
    for size_key, size in image_sizes.items():
        if img.width > size:
            new_size = (size, round(img.height * (size / img.width)))
            img = img.resize(new_size)
        else:
            continue
        setattr(file_object, 'thumbnail_{}'.format(size_key), True)
        img.save('uploads/{}_{}.{}'.format(qquuid, size_key, extension))

    return file_object


def handle_arbitrary_file_upload(file, qquuid) -> File:
    """
    Processes an uploaded file of any type.
    :param file: Uploaded file object.
    :param qquuid: Identifier for the image, generated by the uploader.
    :return: Created file model.
    """
    # Create file object
    file_entity = File()
    filename_parts = file.filename.split('.')
    extension = ''
    if len(filename_parts) > 1:
        extension = file.filename.split('.')[-1]
    file_entity.filename = '{}.{}'.format(qquuid, extension)
    file_entity.original_filename = file.filename

    # Move file to uploads folder destination
    file.stream.seek(0)
    file.save('uploads/{}.{}'.format(qquuid, extension))

    return file_entity