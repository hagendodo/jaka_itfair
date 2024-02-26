@extends('layouts.app')

@section('content')
    <div class="page-wrapper">
        <div class="page-breadcrumb">
            <div class="row">
                <div class="col-5 align-self-center">
                    <h4 class="page-title">Dashboard</h4>
                </div>

            </div>
        </div>

        <div class="container-fluid">
            <div class="row">
                @php
                    function formatDate($dateString) {
                        $date = new DateTime($dateString);
                        return $date->format('l, d - m - Y');
                    }
                @endphp
                @foreach($orders as $order)
                    <div class="col-lg-3 col-md-4 col-sm-12">
                        <div class="card p-3">
                            <div class="card-body">
                                <h3 class="card-title m-b-5">{{$order['user']['name']}}</h3>
                                <h5 class="font-light">Rp. {{$order['total']}}</h5>
                                <p>{{formatDate($order['created_at'])}}</p>
                            </div>
                            <div class="text-right">
                                <button type="button" class="btn btn-warning" data-toggle="modal"
                                        data-target="#editModal-{{$order['id']}}">
                                    Tolak
                                </button>
                                <button type="button" class="btn btn-danger" data-toggle="modal"
                                        data-target="#hapusModal-{{$order['id']}}">
                                    Terima
                                </button>
                            </div>

                            <div class="modal fade" id="editModal-{{$order['id']}}" tabindex="-1" role="dialog"
                                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <form method="POST"
                                              action="{{ route('orders.decline', ['order' => $order['id']]) }}">
                                            @csrf
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Terima Pesanan</h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <input type="text" name="merchant_id" value="{{session('merchant_id')}}"
                                                       hidden="hidden">
                                                <div class="form-group">
                                                    <label>Nama Product</label>
                                                    <input type="text" class="form-control" name="name"
                                                           value="{{$order['name']}}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label>Harga</label>
                                                    <input type="number" class="form-control" name="price"
                                                           value="{{$order['price']}}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label>Deskripsi</label>
                                                    <textarea class="form-control" name="description"
                                                              required>{{$order['description']}}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label>Gambar Product</label>
                                                    <input type="file" class="form-control" name="filename" required>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary">Simpan</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="hapusModal-{{$order['id']}}" tabindex="-1" role="dialog"
                                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Hapus Data</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Apakah yakin ingin menghapus produk ini?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <form method="POST"
                                                  action="{{ route('orders.destroy', ['order' => $order['id']]) }}">
                                                @csrf
                                                @method('DELETE')
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                    Batal
                                                </button>
                                                <button type="submit" class="btn btn-danger">Hapus</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </div>
@endsection
