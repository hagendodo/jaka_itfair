<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Verifikasi Penjamu') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <table id="example" class="display" style="width:100%">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>ID</th>
                            <th>NIM</th>
                            <th>Nama</th>
                            <th>Phone/Whatsapp</th>
                            <th>Verified</th>
                            <th>Status</th>
                            <th>Problem</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($penjamus as $penjamu)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $penjamu['id'] }}</td>
                                <td>{{ $penjamu['nim'] }}</td>
                                <td>{{ $penjamu['name'] }}</td>
                                <td>{{ $penjamu['phone'] }}</td>
                                <td>{{ $penjamu['is_verified'] === null?"NOT ACTIVATED":($penjamu['is_verified']?"ACCEPTED":"DECLINED") }}</td>
                                <td>{{ $penjamu['is_activated'] === false ? "DEACTIVE":"" }}</td>
                                <td>{{ $penjamu['is_problem'] }}</td>
                                <td>
                                    <!-- Button trigger modal -->
                                    @if( $penjamu['is_verified'] === null)
                                    <button type="button" class="btn btn-outline-primary" data-toggle="modal"
                                            data-target="#verifyModal-{{$penjamu['id']}}">
                                        Verifikasi
                                    </button>
                                    @endif

                                    @if( $penjamu['is_activated'] !== false)
                                    <button type="button" class="btn btn-outline-danger" data-toggle="modal"
                                            data-target="#deactivateModal-{{$penjamu['id']}}">
                                        Deactivate
                                    </button>
                                    @else
                                        <button type="button" class="btn btn-outline-success" data-toggle="modal"
                                                data-target="#activateModal-{{$penjamu['id']}}">
                                            Activate
                                        </button>
                                    @endif

                                    <!-- Modal -->
                                    <div class="modal fade" id="verifyModal-{{$penjamu['id']}}" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Verifikasi Penjamu</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <img src="https://assets-global.website-files.com/64abfb060667e3285fe19983/64f00ba612b2fd18a68dd1c7_contoh%20KTM.jpeg" width="600" height="auto" alt="FOTO KTM"/>

                                                    <div class="row mt-4">
                                                        <div class="col text-left">
                                                            <form method="POST" action="{{ route('auth.decline', ['id' => $penjamu['id']]) }}">
                                                                @csrf
                                                                <input type="text" hidden="hidden" name="type" value="penjamu">
                                                                <button type="submit" class="btn btn-outline-danger">Decline</button>
                                                            </form>
                                                        </div>
                                                        <div class="col text-right">
                                                            <form method="POST" action="{{ route('auth.accept', ['id' => $penjamu['id']]) }}">
                                                                @csrf
                                                                <input type="text" hidden="hidden" name="type" value="penjamu">
                                                                <button type="submit" class="btn btn-outline-success">Accept</button>
                                                            </form>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="deactivateModal-{{$penjamu['id']}}" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Deactivate Penjamu</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Apakah kamu yakin ingin menonaktifkan akun penjamu ini?</p>
                                                    <p><b>Problem:</b></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <form method="POST" action="{{ route('auth.deactive', ['id' => $penjamu['id']]) }}">
                                                        @csrf
                                                        <input type="text" hidden="hidden" name="type" value="penjamu">
                                                        <button type="submit" class="btn btn-outline-danger">Deactivate</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="activateModal-{{$penjamu['id']}}" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Activate Penjamu</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Apakah kamu yakin ingin mengaktifkan kembali akun penjamu ini?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <form method="POST" action="{{ route('auth.active', ['id' => $penjamu['id']]) }}">
                                                        @csrf
                                                        <input type="text" hidden="hidden" name="type" value="penjamu">
                                                        <button type="submit" class="btn btn-outline-success">Activate</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/2.0.0/js/dataTables.min.js"></script>
    <script>

        new DataTable('#example');
    </script>
</x-app-layout>
