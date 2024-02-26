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
                @foreach($orders as $order)
                    <div class="col-lg-4 col-md-6 col-sm-12">
                        <div class="card p-3">
                            <div class="card-body">
                                <h3 class="card-title m-b-5">{{$order['users']['name']}}</h3>
                                <h5 class="font-light">Rp. {{$order['total']}}</h5>
                                <p>{{(new DateTime($order['created_at']))->format('l, d - m - Y')}}</p>
                                <p>Penjamu: <b>{{$order['penjamus']?$order['penjamus']['name']:"-"}}</b></p>
                            </div>
                            @if($order['status'] == null)
                                <div class="text-right">
                                    <button type="button" class="btn btn-danger" data-toggle="modal"
                                            data-target="#editModal-{{$order['id']}}">
                                        Tolak
                                    </button>
                                    <button type="button" class="btn btn-success" data-toggle="modal"
                                            data-target="#hapusModal-{{$order['id']}}">
                                        Terima
                                    </button>
                                </div>

                                <div class="modal fade" id="editModal-{{$order['id']}}" tabindex="-1" role="dialog"
                                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <form method="POST"
                                                  action="{{ route('orders.matching', ['order' => $order['id']]) }}">
                                                @csrf
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Terima Pesanan</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Apakah yakin ingin menolak pesanan ini?</p>
                                                    <h3>{{$order['users']['name']}}</h3>
                                                    <p>{{$order['total']}}</p>
                                                    <p>Penjamu: <b>{{$order['penjamus']?$order['penjamus']['name']:""}}</b></p>
                                                    <p>Dikirim ke: {{$order['address']}}</p>

                                                    <p>List Pesanan:</p>
                                                    <ol>
                                                        @foreach($order['detail_orders'] as $detail)
                                                            <li>{{$detail['products']?$detail['products']['name']:""}} (x{{$detail['quantity']}})</li>
                                                        @endforeach
                                                    </ol>
                                                    <input type="text" name="merchant_id" value="{{session('merchant_id')}}"
                                                           hidden="hidden">
                                                    <input type="text" name="status" value="canceled"
                                                           hidden="hidden">
                                                    <input type="text" name="order_id" value="{{$order['id']}}"
                                                           hidden="hidden">
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                        Batal
                                                    </button>
                                                    <button type="submit" class="btn btn-danger">Tolak</button>
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
                                                <h5 class="modal-title" id="exampleModalLabel">Terima Pesanan</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <h3>{{$order['users']['name']}}</h3>
                                                <p>{{$order['total']}}</p>
                                                <p>Penjamu: <b>{{$order['penjamus']?$order['penjamus']['name']:""}}</b></p>
                                                <p>Dikirim ke: {{$order['address']}}</p>

                                                <p>List Pesanan:</p>
                                                <ol>
                                                    @foreach($order['detail_orders'] as $detail)
                                                        <li>{{$detail['products']?$detail['products']['name']:""}} (x{{$detail['quantity']}})</li>
                                                    @endforeach
                                                </ol>
                                            </div>
                                            <div class="modal-footer">
                                                <form method="POST"
                                                      action="{{ route('orders.matching', ['order' => $order['id']]) }}">
                                                    @csrf
                                                    <input type="text" name="merchant_id" value="{{session('merchant_id')}}"
                                                           hidden="hidden">
                                                    <input type="text" name="status" value="active"
                                                           hidden="hidden">
                                                    <input type="text" name="order_id" value="{{$order['id']}}"
                                                           hidden="hidden">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                        Batal
                                                    </button>
                                                    <button type="submit" class="btn btn-success">Terima</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endif
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </div>
@endsection
