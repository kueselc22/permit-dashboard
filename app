import { useEffect, useState } from "react";

const SHEETDB_API = "https://sheetdb.io/api/v1/j6bcyky25ejua";

interface Permit {
  project: string;
  address: string;
  zip: string;
  status: string;
  submitted: string;
}

export default function PermitDashboard() {
  const [permits, setPermits] = useState<Permit[]>([]);
  const [filter, setFilter] = useState("");

  useEffect(() => {
    const fetchPermits = async () => {
      try {
        const res = await fetch(SHEETDB_API);
        const data = await res.json();
        setPermits(data);
      } catch (error) {
        console.error("Failed to fetch permit data:", error);
      }
    };
    fetchPermits();
  }, []);

  const filteredPermits = permits.filter(
    (p) =>
      p.project.toLowerCase().includes(filter.toLowerCase()) ||
      p.address.toLowerCase().includes(filter.toLowerCase())
  );

  return (
    <main className="p-6 max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Permit Activity Dashboard</h1>
      <input
        type="text"
        placeholder="Search by project or address..."
        className="w-full p-3 mb-6 border rounded"
        value={filter}
        onChange={(e) => setFilter(e.target.value)}
      />
      {filteredPermits.length === 0 ? (
        <p>No permit data found for your search.</p>
      ) : (
        filteredPermits.map((permit, idx) => (
          <div
            key={idx}
            className="border rounded p-4 mb-4 shadow-sm hover:shadow-md transition"
          >
            <h2 className="text-xl font-semibold">{permit.project}</h2>
            <p>
              <strong>Address:</strong> {permit.address}
            </p>
            <p>
              <strong>ZIP Code:</strong> {permit.zip}
            </p>
            <p>
              <strong>Status:</strong> {permit.status}
            </p>
            <p>
              <strong>Submitted:</strong> {permit.submitted}
            </p>
          </div>
        ))
      )}
    </main>
  );
}
