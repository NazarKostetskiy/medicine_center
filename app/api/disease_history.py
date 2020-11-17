import shutil
import os
import uuid

from fastapi import APIRouter, File, UploadFile
from starlette.responses import FileResponse
from bson.objectid import ObjectId

from app.validators.schemes.user_schemes import DiseaseHistoryScheme
from app.disease_storage.upload_file import FileUploader
from app.database.disease_history import HistoriesCollection
from config import CLEARED_DIR

router = APIRouter()


@router.get('/{patient_id}')
async def get_disease_histories(patient_id: str):
    """
    Get list of disease histories of some user
    :param patient_id:
    :return: list of histtories
    """

    histories_patient = HistoriesCollection.get_objs({'patient_id': patient_id},
                                                     fields=('_id', 'title', 'date_updated', 'status'))

    if not histories_patient:
        return {'data': {}, 'result': False}, 200

    return histories_patient


@router.get('/read_history/{history_id}')
async def get_history(history_id: str):
    """
    Get history of some patient with some id of history
    :param history_id: id of history in the database
    :return: histories with history_id
    """
    history = HistoriesCollection.get_one_obj({'_id': ObjectId(history_id)})

    if not history:
        return {'data': {}, 'result': False}, 200

    return history


@router.post('/disease_history/add')
async def add_history(history: DiseaseHistoryScheme):
    """
    Add to database new disease history for user
    :param history: dict of data to add to database
    :return:
    """
    HistoriesCollection.insert_obj(dict(history))


@router.put('/disease_history/update/{history_id}')
async def update_history(history_id: str, history: DiseaseHistoryScheme):
    """
    Update history with id - history_id
    :param history_id: id of history in the database
    :param history: dict of data to add to database
    :return:
    """
    HistoriesCollection.update_obj_by_id(history_id, dict(history))


@router.delete('/disease_history/delete/{history_id}')
async def delete_history(history_id: str):
    """
    Delete history with id - history_id
    :param history_id: id of history in the database
    :return:
    """
    HistoriesCollection.delete_obj_by_id(history_id)


@router.post("/uploadfile/{history_id}")
async def upload_file(history_id: str, file: UploadFile = File(...)):
    """
    upload file to google cloud storage
    :param history_id: id of history in the database
    :param file: file to uploading
    :return:
    """
    with open(file.filename, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    new_filename = str(uuid.uuid4()) + '.' + file.filename.split('.')[-1]
    os.renames(file.filename, new_filename)
    shutil.move(new_filename, "app/disease_storage/")

    file_uploader = FileUploader()
    file_uploader.upload_file('app/disease_storage/'+new_filename, new_filename)

    os.remove('app/disease_storage/'+new_filename)

    HistoriesCollection.update_obj_by_id(history_id, {'file_name': new_filename})

    return {"filename": new_filename}


@router.get("/download/{history_id}")
async def download_file(history_id: str):
    filename = HistoriesCollection.get_one_obj({'_id': ObjectId(history_id)})['file_name']

    if filename not in os.listdir(CLEARED_DIR):
        file_uploader = FileUploader()
        file_uploader.download_file(filename)

    shutil.move(filename, "app/disease_storage/")

    return FileResponse('app/disease_storage/'+filename, media_type='application/octet-stream', filename=filename)
