<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Manage Merchant') }}
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
                            <th>Nama</th>
                            <th>Alamat</th>
                            <th>Location</th>
                            <th>Phone/Whatsapp</th>
                            <th>Status</th>
                            <th>Problem</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($merchants as $merchant)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $merchant['id'] }}</td>
                                <td>{{ $merchant['name'] }}</td>
                                <td>{{ $merchant['address'] }}</td>
                                <td>({{ $merchant['lng'] }},{{ $merchant['lat'] }})</td>
                                <td>{{ $merchant['phone'] }}</td>
                                <td>{{ $merchant['is_activated'] === false ? "DEACTIVATE":($merchant['is_activated'] === null?"NOT ACTIVATED":"ACTIVATED") }}</td>
                                <td>{{ $merchant['is_problem'] }}</td>
                                <td>
                                    @if( $merchant['is_activated'] === true)
                                    <button type="button" class="btn btn-outline-danger" data-toggle="modal"
                                            data-target="#deactivateModal-{{$merchant['id']}}">
                                        Deactivate
                                    </button>
                                    @else
                                        <button type="button" class="btn btn-outline-success" data-toggle="modal"
                                                data-target="#activateModal-{{$merchant['id']}}">
                                            Activate
                                        </button>
                                    @endif

                                    <!-- Modal -->
                                    <div class="modal fade" id="deactivateModal-{{$merchant['id']}}" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Deactivate User</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Apakah kamu yakin ingin menonaktifkan akun merchant ini?</p>
                                                    <p><b>Problem:</b></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <form method="POST" action="{{ route('auth.deactive', ['id' => $merchant['id']]) }}">
                                                        @csrf
                                                        <input type="text" hidden="hidden" name="type" value="merchant">
                                                        <button type="submit" class="btn btn-outline-danger">Deactivate</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="activateModal-{{$merchant['id']}}" tabindex="-1" role="dialog"
                                         aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Konfirmasi Activate User</h5>
                                                    <button type="button" class="close" data-dismiss="modal"
                                                            aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Apakah kamu yakin ingin mengaktifkan kembali akun merchant ini?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <form method="POST" action="{{ route('auth.active', ['id' => $merchant['id']]) }}">
                                                        @csrf
                                                        <input type="text" hidden="hidden" name="type" value="merchant">
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
