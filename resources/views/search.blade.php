    <div class="container py-5">
        <h1 class="text-center mb-4">Search for Available Blood</h1>

        {{-- Search Form --}}
        <div class="card shadow-sm mb-5 mx-auto" style="max-width: 500px;">
            <div class="card-body">
                <form action="{{ route('blood.handleSearch') }}" method="POST">
                    @csrf
                    <div class="mb-3">
                        <label for="blood_group_id" class="form-label">Select Blood Group</label>
                        <select class="form-select @error('blood_group_id') is-invalid @enderror" id="blood_group_id" name="blood_group_id" required>
                            <option value="">-- Please Select --</option>
                            @foreach($bloodGroups as $group)
                                <option value="{{ $group->id }}" {{ (isset($searchedBloodGroup) && $searchedBloodGroup->id == $group->id) ? 'selected' : '' }}>
                                    {{ $group->group_name }}
                                </option>
                            @endforeach
                        </select>
                        @error('blood_group_id')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </form>
            </div>
        </div>

        {{-- Results Display --}}
        @if(isset($stockCount))
            <div class="card text-center mx-auto" style="max-width: 500px;">
                <div class="card-header">
                    Search Results for Blood Group: <strong>{{ $searchedBloodGroup->group_name }}</strong>
                </div>
                <div class="card-body">
                    @if($stockCount > 0)
                        <h5 class="card-title text-success">Good News!</h5>
                        <p class="fs-4">We currently have <strong>{{ $stockCount }}</strong> unit(s) available.</p>
                        <p class="card-text">Please contact us immediately to proceed with the necessary formalities.</p>
                        {{-- <a href="{{ route('contact') }}" class="btn btn-success">Contact Blood Bank</a> --}}
                    @else
                        <h5 class="card-title text-danger">Stock Not Available</h5>
                        <p class="fs-4">Unfortunately, we do not have any units of <strong>{{ $searchedBloodGroup->group_name }}</strong> available right now.</p>
                        <p class="card-text">You can submit an urgent request, and we will notify you as soon as a match is found.</p>
                        {{-- <a href="{{ route('blood.request') }}" class="btn btn-warning">Submit a Blood Request</a> --}}
                    @endif
                </div>
            </div>
        @endif
    </div>
