/* eslint-disable @typescript-eslint/no-empty-object-type */
/* eslint-disable @typescript-eslint/no-explicit-any */
'use client'

import { useState } from 'react';
import { useDebouncedCallback } from 'use-debounce';

interface Investor {
  name: string;
  requested_amount: number;
  average_amount: number;
}

interface ProrationFormProps {}

export default function ProrationForm({}: ProrationFormProps) {
  const [allocation, setAllocation] = useState<string>('');
  const [investors, setInvestors] = useState<Investor[]>([{ name: '', requested_amount: 0, average_amount: 0 }]);
  const [proratedAmounts, setProratedAmounts] = useState<Record<string, number>>({});

  const debouncedFetch = useDebouncedCallback(async (name: string, index: number) => {
    try {
      const slug = name.toLowerCase().replace(/\s+/g, '-');
      // The slug is created from the name input, so it will match the investor's name
      // e.g. "Investor A" becomes "investor-a"
      const response = await fetch(`http://localhost:3001/api/investors/${encodeURIComponent(slug)}`, {
        cache: 'no-store'
      });

      const data = await response.json();

      console.log('*** data', data);

      const updatedInvestors = [...investors];
      updatedInvestors[index] = {
        ...updatedInvestors[index],
        average_amount: data.average_investment_amount || 0
      };
      setInvestors(updatedInvestors);
    } catch (error) {
      console.error('*** Error fetching investor average:', error);
    }
  }, 300);

  const fetchInvestorAverage = (name: string, index: number) => {
    if (name && name.length > 0) {
      debouncedFetch(name, index);
    }
  };

  const handleAddInvestor = () => {
    setInvestors([...investors, { name: '', requested_amount: 0, average_amount: 0 }]);
  };

  const handleRemoveInvestor = (index: number) => {
    const updatedInvestors = investors.filter((_, i) => i !== index);
    setInvestors(updatedInvestors);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    try {
      const response = await fetch('http://localhost:3000/api/prorate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          allocation_amount: parseFloat(allocation),
          investor_amounts: investors.filter(inv => inv.name && inv.requested_amount)
        }),
      });
      
      const data = await response.json();

      console.log('*** data', data);

      setProratedAmounts(data);
    } catch (error) {
      console.error('Error calculating proration:', error);
    }
  };

  const handleInvestorNameChange = (e: React.ChangeEvent<HTMLInputElement>, investor: any, index: number) => {
    const name = e.target.value;
      const updatedInvestors = [...investors];
      updatedInvestors[index] = { ...investor, name };
      setInvestors(updatedInvestors);

      fetchInvestorAverage(name, index);
  }

  return (
    <form onSubmit={handleSubmit} className="max-w-4xl mx-auto p-6 space-y-6">
      <div className="space-y-4">
        <h2 className="text-2xl font-bold">Proration Calculator</h2>
        
        <div className="flex items-center space-x-4">
          <label className="w-48">Total Available Allocation:</label>
          <div className="relative">
            <span className="absolute left-3 top-2">$</span>
            <input
              type="number"
              value={allocation}
              onChange={(e) => setAllocation(e.target.value)}
              className="pl-8 pr-4 py-2 border rounded"
              placeholder="0.00"
              step="0.01"
              min="0"
              required
            />
          </div>
        </div>
      </div>

      <div className="space-y-4">
        <h3 className="text-xl font-semibold">Investor Breakdown</h3>
        
        <div className="space-y-4">
          {investors.map((investor, index) => (
            <div key={index} className="flex items-center space-x-4">
              <input
                type="text"
                value={investor.name}
                onChange={(e) => handleInvestorNameChange(e, investor, index)}
                className="w-48 px-4 py-2 border rounded"
                placeholder="Investor Name"
                required
              />
              
              <div className="relative">
                <span className="absolute left-3 top-2">$</span>
                <input
                  type="number"
                  value={investor.requested_amount || ''}
                  onChange={(e) => {
                    const updatedInvestors = [...investors];
                    updatedInvestors[index] = { ...investor, requested_amount: parseFloat(e.target.value) };
                    setInvestors(updatedInvestors);
                  }}
                  className="pl-8 pr-4 py-2 border rounded"
                  placeholder="0.00"
                  step="0.01"
                  min="0"
                  required
                />
              </div>
              
              <div className="relative">
                <span className="absolute left-3 top-2">$</span>
                <input
                  type="number"
                  value={investor.average_amount || ''}
                  className="pl-8 pr-4 py-2 border rounded bg-gray-800"
                  placeholder="0.00"
                  readOnly
                />
              </div>
              
              {index > 0 && (
                <button
                  type="button"
                  onClick={() => handleRemoveInvestor(index)}
                  className="px-3 py-2 text-red-600 hover:text-red-800"
                >
                  Remove
                </button>
              )}
            </div>
          ))}
        </div>
        
        <button
          type="button"
          onClick={handleAddInvestor}
          className="px-4 py-2 text-blue-600 hover:text-blue-800"
        >
          + Add Investor
        </button>
      </div>

      <div className="pt-6">
        <button
          type="submit"
          className="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
        >
          Calculate Proration
        </button>
      </div>

      {Object.keys(proratedAmounts).length > 0 && (
        <div className="mt-8 space-y-4">
          <h3 className="text-xl font-semibold">Prorated Amounts</h3>
          <div className="space-y-2">
            {Object.entries(proratedAmounts).map(([name, amount]) => (
              <div key={name} className="flex justify-between">
                <span>{name}:</span>
                <span>${amount.toFixed(2)}</span>
              </div>
            ))}
          </div>
        </div>
      )}
    </form>
  );
} 